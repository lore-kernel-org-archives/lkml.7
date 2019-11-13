Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3394EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A54B21872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwCXlilA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKMAWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:22:54 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45650 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKMAWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:22:53 -0500
Received: by mail-yb1-f195.google.com with SMTP id i7so242361ybk.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uoHLiIOTAvogZLXBSvSivaMAQZVUp11N48xeT9xKFAA=;
        b=EwCXlilAXQiZt2NJehm8cfebO0K98eji/w6iFgqsA/yjgo8IpeJYsx59KZmazUD3rk
         7rD45eB6UgEddYjXrM2EMvsWgwKhHC5wIetNQkZycmdKiNxn9cdQLGuigpCfiyoCbior
         dIOeisgA8iVjTuAUaOOL5sLpivHUanRWGezLwM4DO+P5TOJCve4WRrzwu29KVx7n5497
         NAVojv+6Z2YiqIlm66G9gSYt/QqRLc0uTSr9j0K4iRcSIWDAKYuAMo/l4sX4H8qDGBt2
         1IDQsmL+0lj42ZaQdwOkTMOmqedUIkkWRDrbYkRUgXjKh7gZctFNhqTl/SGklm5Ruyrm
         loyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uoHLiIOTAvogZLXBSvSivaMAQZVUp11N48xeT9xKFAA=;
        b=Cgvc9pA+TDQ7kuM70+0kiNOa9SKKj9xUjSp1T3UN6avSNtNK4/EeVjtK/Z2CwOoRHJ
         Puxm4abja4r6d4/iBKYI3sbUbgPkh+sIZPnzeAuO6luBL+IG7CLvGgqqFuwORTFFP5a7
         CXwenM+tS4jWuAhSiC0V3vlhaJTjGiNgDkTGEPxtFMLjgUuZfuSrp4d6jZfxi3qFZA+1
         Mx8KWQaGiDXhzhKgaSuITk5Q7g1IfC2I3ajf9Z8k8rpbW6fjY5qzWpxwbv2GYJXa2nQ7
         WEYf2Fgsbw/M8rmS3fo+G7Zz2dqhELz+TbwH/g8jXTKaCIzwj6J+D9yyo5YUEB9I2SNF
         xXIQ==
X-Gm-Message-State: APjAAAUh5VdIbrjtFw4lj+x/+0OM2eL/6dujrWKcVIiWF1c/6BOUgpq3
        0Y/BJW6u4WzQ7GIwbb3LIfo=
X-Google-Smtp-Source: APXvYqxsDUg4EGjGOAqHx+7d2s0ZZ8rLav0Kg3bt8kI4CZUKKRRBQNMZhmFZd9UY+unfJwz5YjZM0w==
X-Received: by 2002:a25:7909:: with SMTP id u9mr548476ybc.327.1573604572770;
        Tue, 12 Nov 2019 16:22:52 -0800 (PST)
Received: from gmail.com ([196.247.56.44])
        by smtp.gmail.com with ESMTPSA id r33sm134916ywa.83.2019.11.12.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 16:22:52 -0800 (PST)
Date:   Tue, 12 Nov 2019 19:22:48 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] Re: [PATCH 5/9] staging: rtl8723bs: Add
 necessary braces
Message-ID: <20191113002248.u4cwx7bwjenpzwbj@gmail.com>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
 <9653d1c5ea7ebd7b4137edea4f5eef74ea65703b.1573577309.git.jarias.linux@gmail.com>
 <20191112230405.GA1904763@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112230405.GA1904763@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

The unbalanced braces were fixed in the patch #6. I thought that
given that Checkpatch detects them as different issues I could only
change single lines and fix the unbalanced ones in the next patch.

I'll edit the patches then.

On Wed, Nov 13, 2019 at 12:04:05AM +0100, Greg KH wrote:
> On Tue, Nov 12, 2019 at 11:54:32AM -0500, Javier F. Arias wrote:
> > This patchset adds braces when they should be used on all arms of
> > the statement.
> > Issue found by Checkpatch.
> > 
> > Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_xmit.c | 31 +++++++++++++++--------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> > index fdb585ff5925..42bd5d8362fa 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> > @@ -370,8 +370,9 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
> >  	/* 		Other fragments are protected by previous fragment. */
> >  	/* 		So we only need to check the length of first fragment. */
> >  	if (pmlmeext->cur_wireless_mode < WIRELESS_11_24N  || padapter->registrypriv.wifi_spec) {
> > -		if (sz > padapter->registrypriv.rts_thresh)
> > +		if (sz > padapter->registrypriv.rts_thresh) {
> >  			pattrib->vcs_mode = RTS_CTS;
> > +		}
> >  		else {
> 
> The } should be on the same line as the "else {"
> 
> thanks,
> 
> greg k-h
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191112230405.GA1904763%40kroah.com.
