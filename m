Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7B2C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D0C2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559721829;
	bh=gUfiC+oPuGCxyMRagfwhv+ld1NkJ9NlUvzZTY/jEu8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=kaO3F9w/uLIBCn+eCeAtPvI0POwG2c/NL77+kUPAcQt9lkCUxKVaSjujuj4W0H44I
	 YlfXkGlMGUL+o/IUKtDmO61+CkkfJYKtLNCqgdRIyOjcxOm22/qBINNLagK0srYpJs
	 /k3ECT/ou82ApUYgs0u+sAmBkSlUeMY9ACi0FMHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFEIDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:03:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:56934 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfFEIDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:03:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 01:03:47 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2019 01:03:46 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        v.anuragkumar@gmail.com,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG entry
In-Reply-To: <1559141985-17104-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1559141985-17104-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Date:   Wed, 05 Jun 2019 11:03:42 +0300
Message-ID: <87y32gcvc1.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
> As a process of preparing TRBs usb_gadget_map_request_by_dev() is
> called from dwc3_prepare_trbs() for mapping the request. This will
> call dma_map_sg() if req->num_sgs are greater than 0. dma_map_sg()
> will map the sg entries in sglist and return the number of mapped SGs.
> As a part of mapping, some sg entries having contigous memory may be
> merged together into a single sg (when IOMMU used). So, the number of
> mapped sg entries may not be equal to the number of orginal sg entries
> in the request (req->num_sgs).
>
> As a part of preparing the TRBs, dwc3_prepare_one_trb_sg() iterates over
> the sg entries present in the sglist and calls sg_is_last() to identify
> whether the sg entry is last and set IOC bit for the last sg entry. The
> sg_is_last() determines last sg if SG_END is set in sg->page_link. When
> IOMMU used, dma_map_sg() merges 2 or more sgs into a single sg and it
> doesn't retain the page_link properties. Because of this reason the
> sg_is_last() may not find SG_END and thus resulting in IOC bit never
> getting set.
>
> For example:
>
> Consider a request having 8 sg entries with each entry having a length of
> 4096 bytes. Assume that sg1 & sg2, sg3 & sg4, sg5 & sg6, sg7 & sg8 are
> having contigous memory regions.
>
> Before calling dma_map_sg():
>             sg1-->sg2-->sg3-->sg4-->sg6-->sg7-->sg8
> dma_length: 4K    4K    4K    4K    4K    4K    4K
> SG_END:     False False False False False False True
> num_sgs =3D 8
> num_mapped_sgs =3D 0
>
> The dma_map_sg() merges sg1 & sg2 memory regions into sg1->dma_address.
> Similarly sg3 & sg4 into sg2->dma_address, sg5 & sg6 into the
> sg3->dma_address and sg6 & sg8 into sg4->dma_address. Here the memory
> regions are merged but the page_link properties like SG_END are not
> retained into the merged sgs.

isn't this a bug in the scatterlist mapping code? Why doesn't it keep
SG_END?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlz3d14ACgkQzL64meEa
mQbIKA/+Ii2ChJ8pGwu2ghUPIQnqcxUB7blHV78JMz1exJzlZJ1nJa+LicAky5rJ
k2h0k2Ieaxqj/BExNkC6Q/NtDLSOKPIf7BHjZrjE60JnXexPFUuZiaupVVzVK356
5Y+VDvWVYW8q3DH4g4x7v3Z+ceY6cZiNYLnpKShdnsSyBJTrveTgMR375eYmgMZP
vSc9eqDtN4goT2uqx3uBF6ZvT1r5Cwx1snmqSQiWGg+iDkVJbBC52IxS7mS5S85G
cLQuIrMrJTwk/QS0xlrQjk5uJCZekruiRD5GsktWx+iUb0J2WAbaD3QYU/Hba/xQ
qOdGkj/VPDfo4a0y2nVQIJd5ck6KEV1iOaAN0jx78PR0459nhQeZY19yGdkvTU9L
wW2q7idyaiEDiZUMpaDyq6M+lfBCQUcYjJ5bCUluQEXwJy7srsuQlIh4s+XCCAVM
puN3zV6f8FD+xJLCqQ0alw2JjbjZn53mW0W8eMTD2CSTFSl9GcCAdfblgmhciDBZ
Yqrk8a7s0wDd7fA+/hGYUbJt5efLWHiPYY5Rqeh3GbOVEOP1LTN9/Ipsi6hM+Dxd
FIkH2BjBD99TpIUQlrE+U6iaIUiy8b9pBPiORyjPcHGfdNK/7ITxQ7WWRZJznZRS
MuQ0WAC2u60k8xwzouNwbXL/jcoUP6974/MDeOF5iK4di2YLogg=
=uzJL
-----END PGP SIGNATURE-----
--=-=-=--
