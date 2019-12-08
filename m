Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A0C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D29720637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIYkM5V2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfLHWop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 17:44:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfLHWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 17:44:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB8Mg0ij028743;
        Sun, 8 Dec 2019 22:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=nxsTq9PHt+WagM7s2udxl+yc1ql+5pp2BlLlDniEgQk=;
 b=GIYkM5V2vJe8H6U0JDX0MXzXKzR4oooR8yGdX8cDw2I9eOyHS+5FEXp0QoJKXvA4lDDs
 4nsHhlYAryK2I/wwKVq4BGLGRk2VZDBC58udi+FfdscGiN3NAr2UxB8RmLdZJuR9jnsk
 N9gcOI+D8B9qmmFaS9paJIuZILMfTy0jneVoSsncRumNNMN2m0JmNSHAYB1vwHjNmYU5
 e0l1tBUHbXpa2pZa6MK2TInQhBk0t4aeNOnJIwncPHO6hdfIgpoD3DALQ/DbjaSyw852
 X7mZHSBZjd9s6zehDG/fgKBwGO0D3Xzg9LkhDB4Nj3QkFdoLDbMYHyHoiYnBVXCby4uW 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wr4qr4ddb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Dec 2019 22:44:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB8MeP1Z175563;
        Sun, 8 Dec 2019 22:44:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wrp84cr2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Dec 2019 22:44:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB8Mi5hf006855;
        Sun, 8 Dec 2019 22:44:05 GMT
Received: from tomti.i.net-space.pl (/10.175.202.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Dec 2019 14:44:03 -0800
Date:   Sun, 8 Dec 2019 23:43:57 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     grub-devel@gnu.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, eric.snowberg@oracle.com, hpa@zytor.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, phcoder@gmail.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, krystian.hebel@3mdeb.com,
        maciej.pijanowski@3mdeb.com, michal.zygowski@3mdeb.com,
        piotr.krol@3mdeb.com
Subject: Re: [GRUB PATCH 1/1] loader/i386/linux: Fix an underflow in the
 setup_header length calculation
Message-ID: <20191208224357.ex5uxseu45og7s37@tomti.i.net-space.pl>
References: <20191202172939.29271-1-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202172939.29271-1-daniel.kiper@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9465 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912080195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9465 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912080195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... Nobody cares? Strange...

Adding 3mdeb folks...

Daniel

On Mon, Dec 02, 2019 at 06:29:39PM +0100, Daniel Kiper wrote:
> Recent work around x86 Linux kernel loader revealed an underflow in the
> setup_header length calculation and another related issue. Both lead to
> the memory overwrite and later machine crash.
>
> Currently when the GRUB copies the setup_header into the linux_params
> (struct boot_params, traditionally known as "zero page") it assumes the
> setup_header size as sizeof(linux_i386_kernel_header/lh). This is
> incorrect. It should use the value calculated accordingly to the Linux
> kernel boot protocol. Otherwise in case of pretty old kernel, to be
> exact Linux kernel boot protocol, the GRUB may write more into
> linux_params than it was expected to. Fortunately this is not very big
> issue. Though it has to be fixed. However, there is also an underflow
> which is grave. It happens when
>
>   sizeof(linux_i386_kernel_header/lh) > "real size of the setup_header".
>
> Then len value wraps around and grub_file_read() reads whole kernel into
> the linux_params overwriting memory past it. This leads to the GRUB
> memory allocator breakage and finally to its crash during boot.
>
> The patch fixes both issues. Additionally, it moves the code not related to
> grub_memset(linux_params)/grub_memcpy(linux_params)/grub_file_read(linux_params)
> section outside of it to not confuse the reader.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  grub-core/loader/i386/linux.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/grub-core/loader/i386/linux.c b/grub-core/loader/i386/linux.c
> index d0501e229..ee95cd374 100644
> --- a/grub-core/loader/i386/linux.c
> +++ b/grub-core/loader/i386/linux.c
> @@ -761,17 +761,12 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>      goto fail;
>
>    grub_memset (&linux_params, 0, sizeof (linux_params));
> -  grub_memcpy (&linux_params.setup_sects, &lh.setup_sects, sizeof (lh) - 0x1F1);
> -
> -  linux_params.code32_start = prot_mode_target + lh.code32_start - GRUB_LINUX_BZIMAGE_ADDR;
> -  linux_params.kernel_alignment = (1 << align);
> -  linux_params.ps_mouse = linux_params.padding10 =  0;
>
>    /*
>     * The Linux 32-bit boot protocol defines the setup header end
>     * to be at 0x202 + the byte value at 0x201.
>     */
> -  len = 0x202 + *((char *) &linux_params.jump + 1);
> +  len = 0x202 + *((char *) &lh.jump + 1);
>
>    /* Verify the struct is big enough so we do not write past the end. */
>    if (len > (char *) &linux_params.edd_mbr_sig_buffer - (char *) &linux_params) {
> @@ -779,10 +774,13 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>      goto fail;
>    }
>
> +  grub_memcpy (&linux_params.setup_sects, &lh.setup_sects, len - 0x1F1);
> +
>    /* We've already read lh so there is no need to read it second time. */
>    len -= sizeof(lh);
>
> -  if (grub_file_read (file, (char *) &linux_params + sizeof (lh), len) != len)
> +  if ((len > 0) &&
> +      (grub_file_read (file, (char *) &linux_params + sizeof (lh), len) != len))
>      {
>        if (!grub_errno)
>  	grub_error (GRUB_ERR_BAD_OS, N_("premature end of file %s"),
> @@ -790,6 +788,9 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>        goto fail;
>      }
>
> +  linux_params.code32_start = prot_mode_target + lh.code32_start - GRUB_LINUX_BZIMAGE_ADDR;
> +  linux_params.kernel_alignment = (1 << align);
> +  linux_params.ps_mouse = linux_params.padding10 = 0;
>    linux_params.type_of_loader = GRUB_LINUX_BOOT_LOADER_TYPE;
>
>    /* These two are used (instead of cmd_line_ptr) by older versions of Linux,
> --
> 2.11.0
