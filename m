Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D879C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A412070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYIGyZkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfEMLdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:33:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44969 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfEMLdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:33:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so7048276pfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sB99XFmRAyWkW3m5ctuFRcLtPaisMRs89ovpO9g5Z20=;
        b=kYIGyZkTj4d6TVkn0APzaa/Kp1GKDCt6YDBacpcyl/LIDGQGPL5nJ7ccnor/nCkEOh
         32sncLpjsKlOA7NM8aJaF1046huxDo75yJ8xtmZ9iUdu5cp6ArN+U0186PuZaGIZlTOy
         lk1A79RzbI99/50gbQGtH+emKSTpT9l2XF06RUvEGDlAFz/RntKUpNb+eOnV0y3UpwpO
         hxXuWpOAcSVwWYmOwP4VBgRiPTLOzzv88rv8mEhtBz0OPqxc24FTjPGy5+q18Q2wDX6Q
         cPNvN65+DmJHrVu8X26K1BJSPhBdK6GH3PXhty7BOHOoRLIx3eQcHov7WyVDO3XH/Gb+
         gHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sB99XFmRAyWkW3m5ctuFRcLtPaisMRs89ovpO9g5Z20=;
        b=EIGEJ+Ql7R2qecYXk20oaNuJF6ukr2K1+S2pS5ho3qcl12ITGAIK1gBG2oeAnD0ART
         hO2lgKlXS/1iJgc7A0hRhL0hwHPmj9Mx92kNEyB8/oH1DKp4RudjrP5NRQshp9BBLyZt
         ERMfWE0dDDLaHNB/GiPSgE/hkmTUs4Ci7cXfLqb9wcvPmMSbyaI8iP61mTQVhE57Kwqz
         MOLAXsOMmQBZnfaVTrRfpJqHX58HdL6p5o8ICuHMvCboWE77arGBDaw3jKjAcHAGb8yj
         6oNOkXufXt1huaUBMeIuiTDl+PBpsFLiA6jAJZUQLYvuuBsbodelhE6XrroeFZHVkYce
         tOlQ==
X-Gm-Message-State: APjAAAVQx685rSSjBQ9oUYDQCn5WTr6dL3FzIQIt4S94Sg1BF0vI0lqP
        bIPgXAa9v9m6ktO79ja/E3Q=
X-Google-Smtp-Source: APXvYqxNzG85iHGGCVTDUVTI/DB51+T6KueBdEO9nT0mdo8QEpm1ADDONADwQQQIttRPvwJ18vhEqg==
X-Received: by 2002:a63:ff23:: with SMTP id k35mr526095pgi.139.1557747190119;
        Mon, 13 May 2019 04:33:10 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 85sm5026295pgb.52.2019.05.13.04.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:33:09 -0700 (PDT)
Date:   Mon, 13 May 2019 19:33:01 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190513113253.GA5753@zhanggen-UX430UQ>
References: <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
 <20190512032719.GA16296@zhanggen-UX430UQ>
 <20190512062009.GA25153@kroah.com>
 <20190512084916.GA4615@zhanggen-UX430UQ>
 <20190513073619.GA5580@kroah.com>
 <20190513093730.GA4487@zhanggen-UX430UQ>
 <20190513095809.GA4588@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513095809.GA4588@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:58:09AM +0200, Greg KH wrote:
 
> You have to unwind the loop and free and uninitialize all of the other
> things you just created as well.
Hi Greg,
I don't think we need to unwind the loop. The loop condition 
MIN_NR_CONSOLES is defined as 1 in include/uapi/linux/vt.h. In this
situation, should we free other memory except vc_cons[currcons].d, vc
and vc->vc_screenbuf?
Thanks
Gen
