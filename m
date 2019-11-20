Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F763C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CE320643
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arPc5ay9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfKTSCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:02:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53847 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfKTSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:02:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so611962wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n+AVORr1d4ZvqzZAnGUi+LFa3CeeCaALUsfle3Ql5L4=;
        b=arPc5ay9U8+j7Oa5DBvVRY9g74sTYWWVDDbnsEh1rYLzJv0B7YSrqJ/nGckQivzgql
         Il0elAQC68TVwRUzW42cLK0f82oq2c2sFnDUvGwxi8fneErktMaQdg8Uwa2klEyzlmKR
         hfiJWZyw2TEFQZpozd9ux2OwLR2K1hKeRcVoDueUloI2GQqACDg3oyaAa1bKYUIK0QMo
         iRzdtRBPNXPy6HivLoA095hDj5afKv/G+u3SmwyY7TewjbaDaHDo5jBTz3fKgfWVni37
         qalinmBUr7I8J4SrgAqxCEuXQxh6q68ueGm7ml6Lt3u4aY2DdvqHVoM/cG6gbtYB5dIt
         IJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+AVORr1d4ZvqzZAnGUi+LFa3CeeCaALUsfle3Ql5L4=;
        b=VHiNpB5QuMonpTbTjmPdtgqSvAsrizj8+o3h07gLHOv9pPTU8DM1iqLWuG47O1rEnb
         UZg83ajJPg2Hts4uLdX5PMsVcI293afOk0fPC5OXS/yOCUDa31t6Hr4+W3FTecjupb/6
         +qjB8NELRdAIFz3xJloyQ6bvVsAp+RRXJuposAPFZ7pTN0ZFa97keHFJU6LD/zH/iPyz
         sf/2esq9fawF2kdnLUZhGhsGB8F/D1ILPJZjEUwzeQAfK0NQGSJphmdLyQl3VfeqcPK/
         ykR+/pkgw6q3+OIAYIdD4E2v1zSoqRd/qrphRJN0BFX0mI5XYYi+bi3vd7A4C1rpbdm3
         Rbhw==
X-Gm-Message-State: APjAAAWxBX8AH4ask7rlgJnKrY9sISXJd35OQQYcQS9dzx/ExrZFTwL2
        i20VD0ElVF+D2V/3Nj6W+0NH5g2d
X-Google-Smtp-Source: APXvYqw2r1QPEfMex4xJorOol7udYdnJE5Ux5cKSX+bWnflDNe1jvwxmtEoaw513eUJU5PvSdoDsEw==
X-Received: by 2002:a1c:6a09:: with SMTP id f9mr4847848wmc.15.1574272951326;
        Wed, 20 Nov 2019 10:02:31 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40e1:9900:950c:3e8e:b6df:1425])
        by smtp.gmail.com with ESMTPSA id t185sm21393wmf.45.2019.11.20.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:02:30 -0800 (PST)
Date:   Wed, 20 Nov 2019 19:02:29 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Message-ID: <20191120180229.frd5padrsdxf7hag@ltop.local>
References: <20191120001030.30779-1-luc.vanoostenryck@gmail.com>
 <CH2PR02MB6359CE45D06E908634CDA855CB4F0@CH2PR02MB6359.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB6359CE45D06E908634CDA855CB4F0@CH2PR02MB6359.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 03:59:24PM +0000, Dragan Cvetic wrote:
> Hi Luc,
> 
> For the sake of my understanding I'd like to ask you when the .pole method is defined 
> Why I'm asking this? I have a fairly new book (published in 2017) which suggests what is implemented in SDFEC driver.
> 
> I'll test your suggestions and will come back to you soon.

Well, yes, it changed in July 2017.

The current definition can be found in include/linux/fs.h:
	struct file_operations {
		...
		__poll_t (*poll) (struct file *, struct poll_table_struct *);
		...

The main commit making the change is:
    a3f8683bf7d5 ("->poll() methods should return __poll_t")


The result can be verified by compiling the driver with the command
	make C=2 path/to/the/driver.o
which will use the static analyser 'sparse' to make additional checks
where the difference between 'unsigned int' and __poll_t will matter.
See Documentation/dev-tools/sparse.rst for more info about it.

Best regards,
-- Luc Van Oostenryck
