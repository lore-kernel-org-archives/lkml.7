Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7AD20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YFrVFtek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgABMov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 07:44:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18433 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgABMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:44:50 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0de5960000>; Thu, 02 Jan 2020 04:44:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Jan 2020 04:44:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 Jan 2020 04:44:49 -0800
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jan 2020 12:44:48
 +0000
Date:   Thu, 2 Jan 2020 13:44:45 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Bitan Biswas <bbiswas@nvidia.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V1] nvmem: core: fix memory abort in cleanup path
Message-ID: <20200102124445.GB1924669@ulmo>
References: <1577592162-14817-1-git-send-email-bbiswas@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1577592162-14817-1-git-send-email-bbiswas@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577969047; bh=M4nXVwwJGqs+aUDvMZNjphqsYWX228oIK/q6HAWvcb4=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=YFrVFtek5KChbulujGCab3wmjKXcgTSy1EY0AHygnYTGrhgP5x4646f7OHqCUrq0N
         vMWee0KMUBmFSRCvQFPAsjqoFtXl8hvdGFWHwYIesXUp62Jc6upvI0OIK8shrl47Q7
         VLope7GuSzoIisf5YmXTgpB+YDfrD8g6+0oRQXHsDOd8EvNsBEiLewLeWDP0ZP0df+
         /qmNzr5MCqwqR9dvymUHNmfnot2lr6UaBBnxFvYFgH5abkDUQT/IaNSoaIVXraZgey
         XtSpcxpFeL/pw2INyAfg6PGputMUIBBX506iPGKoBcXlnfhf1dT8MdAzJVl8Welhvj
         dzmgsO1odBKTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2019 at 08:02:42PM -0800, Bitan Biswas wrote:
> nvmem_cell_info_to_nvmem_cell implementation has static
> allocation of name. nvmem_add_cells_from_of() call may
> return error and kfree name results in memory abort. Use
> kasprintf() instead of assigning pointer and prevent kfree crash.
>=20
> [    8.076461] Unable to handle kernel paging request at virtual address =
ffffffffffe44888
> [    8.084762] Mem abort info:
> [    8.087694]   ESR =3D 0x96000006
> [    8.090906]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    8.096476]   SET =3D 0, FnV =3D 0
> [    8.099683]   EA =3D 0, S1PTW =3D 0
> [    8.102976] Data abort info:
> [    8.106004]   ISV =3D 0, ISS =3D 0x00000006
> [    8.110026]   CM =3D 0, WnR =3D 0
> [    8.113154] swapper pgtable: 64k pages, 48-bit VAs, pgdp=3D00000000815=
d0000
> [    8.120279] [ffffffffffe44888] pgd=3D0000000081d30803, pud=3D000000008=
1d30803, pmd=3D0000000000000000
> [    8.129429] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [    8.135257] Modules linked in:
> [    8.138456] CPU: 2 PID: 43 Comm: kworker/2:1 Tainted: G S             =
   5.5.0-rc3-tegra-00051-g6989dd3-dirty #3   [    8.149098] Hardware name: =
quill (DT)
> [    8.152968] Workqueue: events deferred_probe_work_func
> [    8.158350] pstate: a0000005 (NzCv daif -PAN -UAO)
> [    8.163386] pc : kfree+0x38/0x278
> [    8.166873] lr : nvmem_cell_drop+0x68/0x80
> [    8.171154] sp : ffff80001284f9d0
> [    8.174620] x29: ffff80001284f9d0 x28: ffff0001f677e830
> [    8.180189] x27: ffff800011b0b000 x26: ffff0001c36e1008
> [    8.185755] x25: ffff8000112ad000 x24: ffff8000112c9000
> [    8.191311] x23: ffffffffffffffea x22: ffff800010adc7f0
> [    8.196865] x21: ffffffffffe44880 x20: ffff800011b0b068
> [    8.202424] x19: ffff80001122d380 x18: ffffffffffffffff
> [    8.207987] x17: 00000000d5cb4756 x16: 0000000070b193b8
> [    8.213550] x15: ffff8000119538c8 x14: 0720072007200720
> [    8.219120] x13: 07200720076e0772 x12: 07750762072d0765
> [    8.224685] x11: 0773077507660765 x10: 072f073007300730
> [    8.230253] x9 : 0730073207380733 x8 : 0000000000000151
> [    8.235818] x7 : 07660765072f0720 x6 : ffff0001c00e0f00
> [    8.241382] x5 : 0000000000000000 x4 : ffff0001c0b43800
> [    8.247007] x3 : ffff800011b0b068 x2 : 0000000000000000
> [    8.252567] x1 : 0000000000000000 x0 : ffffffdfffe00000
> [    8.258126] Call trace:
> [    8.260705]  kfree+0x38/0x278
> [    8.263827]  nvmem_cell_drop+0x68/0x80
> [    8.267773]  nvmem_device_remove_all_cells+0x2c/0x50
> [    8.272988]  nvmem_register.part.9+0x520/0x628
> [    8.277655]  devm_nvmem_register+0x48/0xa0
> [    8.281966]  tegra_fuse_probe+0x140/0x1f0
> [    8.286181]  platform_drv_probe+0x50/0xa0
> [    8.290397]  really_probe+0x108/0x348
> [    8.294243]  driver_probe_device+0x58/0x100
> [    8.298618]  __device_attach_driver+0x90/0xb0
> [    8.303172]  bus_for_each_drv+0x64/0xc8
> [    8.307184]  __device_attach+0xd8/0x138
> [    8.311195]  device_initial_probe+0x10/0x18
> [    8.315562]  bus_probe_device+0x90/0x98
> [    8.319572]  deferred_probe_work_func+0x74/0xb0
> [    8.324304]  process_one_work+0x1e0/0x358
> [    8.328490]  worker_thread+0x208/0x488
> [    8.332411]  kthread+0x118/0x120
> [    8.335783]  ret_from_fork+0x10/0x18
> [    8.339561] Code: d350feb5 f2dffbe0 aa1e03f6 8b151815 (f94006a0)
> [    8.345939] ---[ end trace 49b1303c6b83198e ]---
>=20
> Fixes: badcdff107cbf ("nvmem: Convert to using %pOFn instead of device_no=
de.name")
>=20
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> ---
>  drivers/nvmem/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9f1ee9c..0fc66e1 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -110,7 +110,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem=
_device *nvmem,
>  	cell->nvmem =3D nvmem;
>  	cell->offset =3D info->offset;
>  	cell->bytes =3D info->bytes;
> -	cell->name =3D info->name;
> +	cell->name =3D kasprintf(GFP_KERNEL, "%s", info->name);

kstrdup() seems more appropriate here.

A slightly more efficient way to do this would be to use a combination
of kstrdup_const() and kfree_const(), which would allow read-only
strings to be replicated by simple assignment rather than duplication.
Note that in that case you'd need to carefully replace all kfree() calls
on cell->name by a kfree_const() to ensure they do the right thing.

Thierry

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4N5b0ACgkQ3SOs138+
s6G/vg//Q+sdp1CPN/wq2VdLF/KNzLIwvNN7HimV9+xkfaimySCH37f6QIdfLXon
h1y80U7c0vZ4dJVeyjsTjPX1k9xdQN4M+DfMIRFP62HgkwuqOdKd86YMs9o2jv54
4n5iX70pwu3bAtGA953HbsVzlqBORl4QZR/OxAcLXLzqY8aOgSxp8eU55wPhmN81
vTW8TODQsWekv3iWbRbLbMRc0o2Oso3X74j6LGyMKjpzwdk5Rb6ZjZ6SZyp6Yp43
fkadHHK5W2oxBcllAsiH2UuI7asntwAbxed6+kQp0fqJZXO39Lbev+vL29bG/lVB
1u2OCupr49r0Q0Q9TOyyR8z8Kogtds99MnnK7coADKue+7Ayi9/hc9pBgjl7HK5i
DVKoapEqWkkhBWsfTmRj8G8dJuFzq15JxkJ6DjfM2S0sgIv1nukWOHMTqa/WKWBq
SzzdVGLl2In6j3GOwY5N2fegYQNiKWVy61bpnODwmtF7RbTaBFh9f49OCLzv+sny
dS0Qgz7hi18f8czcB7/Ove4hvyai4bOySOSiJQlelO/SY1lYesN2YMS5NsMKtqZD
h7m2Kxgyn6vUIcfSQk1WsKiO/T77kVfGLfr8eyyccJ5E7cWM+HStR3Tr4shnUDJP
y9L8IgLrP1oGUxiic2jzn6wGN8XyGzCHHgkec3k1ZH2liZ5sRsM=
=uEQX
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
