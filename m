Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30176C41514
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075CC217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5KWOZoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfHGCSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:18:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45357 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbfHGCSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:18:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so42548951pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UHZy5nJsksJEcPtr5L7F2iEN0udwduLxq7fwXL+vH/4=;
        b=e5KWOZoHXgR5rR84Aj4RJbMiTvbOaTgc1/UvC8lGLTUL4a6BSCoyDyHpbwaHLEd4RG
         2jVQpJknJvKXhZ0ewXvPbFeDFCuhqygS8POMPEef1ofE2+vD19OFdRbdvgWWV0rBv6iL
         v+9lolTyzc+QoeNlxBgIBl4glae31ADxENbiKJZDK3vwrPLUVpE+xlL7CW+epI0/AWFU
         OMxJF63YvR0rvsMDCjLv9bLyuxLm8NXDjGhq1BK4Fid2voEEzhHOXdFrEwjIfN1PYc4d
         M3wix0cPmR4j2hjf144PArB+uornjOPJyaBlJw1LmZ9JY9btUUsHHAAezdoZdV7FWox1
         AjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UHZy5nJsksJEcPtr5L7F2iEN0udwduLxq7fwXL+vH/4=;
        b=CxoE123ILcUXXXpgGY34XbAauISEkSwtl+4YG0vbMPqP69a2Mth/itAiHQGT06R49Y
         Bc/TAlF2NIg0yrDzh/b5Dvbh/86hzLaeQe5o+7K81JOPnj6dX2jep60WwmFhBxTh+Us/
         NRfnai9RD4ehQJtBIRdV8gUET/2YWmBHJpnoYJ0BCIR08sb8jtMbu17M3tnWAM4JKIe+
         8lZyc7GdwkjIXm5hTh1rVWnd0fHeQngYKzb7fuwrJz2DIp+Ju3ujBhEWqPrFeZ7AEqUw
         Fnzast8no8eJFtE83FyxoAuSUDC12cOPtBsuz2omu0wmKOUW7pkIXQpBxqCj1NXU9feM
         ueYg==
X-Gm-Message-State: APjAAAUcjZDL5Vml5Y5siJcMSyaLYbjfBl00hmf+FFKI2N6+a8ls/oz3
        niLi3PhWHEHWiFsJpUb9AcAWoQ==
X-Google-Smtp-Source: APXvYqz/rfhUPSQwiLYSlyou57kBJEt+Y1RYLdnML5Bhn+AFjOeIW4sZ66YFBsRKbaDFflmwd4879Q==
X-Received: by 2002:a17:90a:c20e:: with SMTP id e14mr6436454pjt.0.1565144321621;
        Tue, 06 Aug 2019 19:18:41 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 65sm97278838pgf.30.2019.08.06.19.18.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 19:18:40 -0700 (PDT)
Date:   Tue, 6 Aug 2019 19:18:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: socinfo: Annotate switch cases with fall
 through
Message-ID: <20190807021838.GI30636@minitux>
References: <20190807100803.63007737@canb.auug.org.au>
 <20190807012457.16820-1-bjorn.andersson@linaro.org>
 <20190807115043.2ff429c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807115043.2ff429c1@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06 Aug 18:50 PDT 2019, Stephen Rothwell wrote:

> Hi Bjorn,
> 
> On Tue,  6 Aug 2019 18:24:57 -0700 Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >
> >  				   qcom_socinfo->dbg_root,
> >  				   &qcom_socinfo->info.raw_device_num);
> > +		/* Fall through */
> >  	case SOCINFO_VERSION(0, 11):
> > +		/* Fall through */
> >  	case SOCINFO_VERSION(0, 10):
> > +		/* Fall through */
> >  	case SOCINFO_VERSION(0, 9):
> 
> I don't think you need the comment between consecutive "case"s - just
> where there is actual code.
> 

You're right, will respin the patch.

Thanks,
Bjorn
