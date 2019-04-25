Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A82C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85272217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jbcxuK05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfDYGgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:36:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20452 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfDYGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:36:15 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190425063612epoutp037e0949a478224c5af9a1038a2ffdddd3~YpCpShlrI2303123031epoutp03h
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:36:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190425063612epoutp037e0949a478224c5af9a1038a2ffdddd3~YpCpShlrI2303123031epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556174172;
        bh=10gBqgLbhFGT4nzauM9XYMUc57ogvrKgSpWt5/p4skk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=jbcxuK05enioeWLf5gYkrmUi8WXEAk0NJ+lVQfo5clXgi7PpLUv0cHPG1ddQ31LMN
         mf1eyDuPWEJzrn7GiafCzZpD79R4w6fGRZya7PRqFXAh6SYJ+IlF7iorIefJi1dnuG
         LadshI+J+iUFm8NRlR2VK7PMHe/AfJ/hF8ODSv4E=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.182]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190425063610epcas2p24842be64a38eb60ba9236077fa8f072c~YpCm12Qd30296902969epcas2p2b;
        Thu, 25 Apr 2019 06:36:10 +0000 (GMT)
X-AuditID: b6c32a48-689ff7000000106f-dc-5cc1555867d1
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.9F.04207.85551CC5; Thu, 25 Apr 2019 15:36:08 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/3] drivers: nvme: target: core: fix build break
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Minwoo Im <minwoo.im@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1556102081-11820-2-git-send-email-info@metux.net>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190425063608epcms2p8bfc5a3322e7faf20caea6bb96ca32cc6@epcms2p8>
Date:   Thu, 25 Apr 2019 15:36:08 +0900
X-CMS-MailID: 20190425063608epcms2p8bfc5a3322e7faf20caea6bb96ca32cc6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTQjci9GCMwdVOPovVd/vZLG427may
        OLbjEZPF5V1z2CzmL3vKbvHs9AFmBzaPy2dLPTYvqfeY8OEtm0ffllWMHp83yQWwRuXYZKQm
        pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn5haX5qXrJefnWhkaGBiZAlUm5GT82pxf
        8ES0YvOkZqYGxpOCXYycHBICJhLH5/xn6mLk4hAS2MEocaRpNpDDwcErICjxd4cwSI2wgKvE
        +ffL2EHCQgLyEj9eGUCENSXe7T7DCmKzCahLNEx9xQJiiwiYSzx+spAVZCSzQDeTxPSdW1gg
        dvFKzGh/CmVLS2xfvpURxOYUsJfoOLeaESIuKnFz9Vt2GPv9sflQcRGJ1ntnmSFsQYkHP3cz
        gtwjISAhce+dHYRZL7FlhQXIWgmBFkaJG2/WQrXqSzQ+/wi2llfAV6J5QwPYzSwCqhJ/T8yF
        WuUicef5aTCbGejF7W/nMIPMZAb6cf0ufYjxyhJHbrFAVPBJdBz+yw7z1I55T5ggbGWJj4cO
        QR0pKbH80ms2CNtDouvRJxZIIO9mlDg4bQbjBEaFWYhwnoVk8SyExQsYmVcxiqUWFOempxYb
        FZggx+wmRnBC1PLYwXjgnM8hRgEORiUeXoXIAzFCrIllxZW5hxglOJiVRHjVTQ/GCPGmJFZW
        pRblxxeV5qQWH2I0Bfp/IrOUaHI+MFnnlcQbmhqZmRlYmlqYmhlZKInzPpSeGy0kkJ5Ykpqd
        mlqQWgTTx8TBKdXAGLFq0t/5rtWVy127Ope4W2fsMza6Edj5g2PupvXOPvXhHDJZ5nqRZ5Rb
        DycVfP7vvNrscqisaVDO4SOXCxsYj9uzSu3qq2K6leHix6fFfXuLW9nU2kvOofJK5cnX7JYa
        fozvOPkwbF15wmz2qs+JSnJ3rDgV9sX9N89XMnj9WKnR3v3CGR8lluKMREMt5qLiRADsoHol
        ngMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190424103521epcas3p44a7fc17a216b5696a6feefc781136699
References: <1556102081-11820-2-git-send-email-info@metux.net>
        <1556102081-11820-1-git-send-email-info@metux.net>
        <CGME20190424103521epcas3p44a7fc17a216b5696a6feefc781136699@epcms2p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks good to me. 

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
> Of Enrico Weigelt, metux IT consult
> Sent: Wednesday, April 24, 2019 7:35 PM
> To: linux-kernel@vger.kernel.org
> Cc: axboe@kernel.dk; linux-ide@vger.kernel.org; linux-
> nvme@lists.infradead.org
> Subject: [PATCH 1/3] drivers: nvme: target: core: fix build break
> 
> Build breaks:
> 
>     drivers/nvme/target/core.c: In function 'nvmet_req_alloc_sgl':
>     drivers/nvme/target/core.c:939:12: error: implicit declaration of \
> function 'sgl_alloc'; did you mean 'bio_alloc'? \
> [-Werror=implicit-function-declaration]
>       req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
>                 ^~~~~~~~~
>                 bio_alloc
>     drivers/nvme/target/core.c:939:10: warning: assignment makes pointer \
> from integer without a cast [-Wint-conversion]
>       req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
>               ^
>     drivers/nvme/target/core.c: In function 'nvmet_req_free_sgl':
>     drivers/nvme/target/core.c:952:3: error: implicit declaration of \
> function 'sgl_free'; did you mean 'ida_free'? [-Werror=implicit-function-
> declaration]
>        sgl_free(req->sg);
>        ^~~~~~~~
>        ida_free
> 
> Cause:
> 
>     1. missing include to <linux/scatterlist.h>
>     2. SGL_ALLOC needs to be enabled
> 
> Therefore adding the missing include, as well as Kconfig dependency.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/nvme/target/Kconfig | 1 +
>  drivers/nvme/target/core.c  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index d94f25c..3ef0a4e 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -3,6 +3,7 @@ config NVME_TARGET
>  	tristate "NVMe Target support"
>  	depends on BLOCK
>  	depends on CONFIGFS_FS
> +	select SGL_ALLOC
>  	help
>  	  This enabled target side support for the NVMe protocol, that is
>  	  it allows the Linux kernel to implement NVMe subsystems and
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b3e765a..08851f5 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -8,6 +8,7 @@
>  #include <linux/random.h>
>  #include <linux/rculist.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/scatterlist.h>
> 
>  #include "nvmet.h"
> 
> --
> 1.9.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
