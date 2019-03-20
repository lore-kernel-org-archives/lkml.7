Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D9D218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7V/2UXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCTUof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:44:35 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:38639 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:44:34 -0400
Received: by mail-it1-f181.google.com with SMTP id m18so1014566ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJDKmFv5bZNPCu04WpjAA88xvIr2zAgmNLvX0lslkL8=;
        b=i7V/2UXpSKTF6f3Eq4eh7Nr+eew7WnxY7s3LITeIt8bE2pcEonk4Vh2s6B8K0wmVPA
         C0ZnkESyjDioVq1EDkRD78qYN/IaCGI29GThbCS6q/aGAImCR0X3ENTNorqGRAISt6mY
         /Xe9KSMGLZ6Aq3MnExjhsdn7LgMEDKiZvgdnl4a6pP1JP/Uv1kHGfTOmNoZlXvYiVlQ5
         as7spl9ulm8yrinOpA8qJqaqctDGQyj2htnSyQ79MuCI4thz+HhK5eShsW55xzb0J/Ma
         zQSybh5Ewgs2PV5+vQfSMiJzhA1pZ0/xdS8hgBQHnlcCFqgNlHXSfNsGKrMAZvKanCnC
         yeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJDKmFv5bZNPCu04WpjAA88xvIr2zAgmNLvX0lslkL8=;
        b=W4Wgp0wwioVW3WJeiGxCO2qn9eLdEjb8CrEBogNyv55fKkSj2sd4m596JEg1giN+PY
         ATwjsB5in8bmDuGi9RIsr6ac5uqvz5sX1Ovmcg153qCGMbbv2OGF0bS26Gvy1xzKgw7g
         516yMsmHw1+kxZUIjdLtG6zGlYkIU8r88LVkDrY7xw1tg9HQq1ZzsNQUCiBEt4IxnUXU
         NuX6CxFTJY57YUffM/ICPSYelZjfdgGOuClbQzLJDcHziozplEGZAqk3305155C06ISY
         ISNPjKdvqlqA1LW8452NKnqp+moTsvAdnbyAdu5nRHzElBNiak25Dcq/xRKU0GS8N5Jh
         /cFw==
X-Gm-Message-State: APjAAAUkFLrd5Px8NMQeOWaRdAKTSdpF1tadd4i+dgkKzX2Jz6FiuYVk
        bUSH6ibUpr8BahQ+sXL1xwA=
X-Google-Smtp-Source: APXvYqzPGvDMrNnrksMtAtVrmQB8cHsZ9mRp1JCnPrtQ0TYivnEWi9uR3t3mb30pnrQKw11lMrA+GA==
X-Received: by 2002:a24:2847:: with SMTP id h68mr222999ith.82.1553114673911;
        Wed, 20 Mar 2019 13:44:33 -0700 (PDT)
Received: from tzanussi-mobl ([2601:246:0:7004:98e9:b645:1289:9c63])
        by smtp.googlemail.com with ESMTPSA id f26sm1369536ioh.55.2019.03.20.13.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:44:33 -0700 (PDT)
Message-ID: <1553114672.2015.4.camel@gmail.com>
Subject: Re: dell_smbios KASAN bug
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 15:44:32 -0500
In-Reply-To: <20190320163227.3aa924c2@gandalf.local.home>
References: <1553106560.2080.5.camel@gmail.com>
         <20190320144146.08ecd5e4@gandalf.local.home>
         <1553108749.2079.1.camel@gmail.com>
         <20190320151353.1a223c0e@gandalf.local.home>
         <1553110221.2034.1.camel@gmail.com>
         <20190320154534.46ebab51@gandalf.local.home>
         <1553113736.2015.2.camel@gmail.com>
         <20190320163227.3aa924c2@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 16:32 -0400, Steven Rostedt wrote:
> On Wed, 20 Mar 2019 15:28:56 -0500
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > > > Unfortunately, no.  
> > > 
> > > That's really weird. I would recommend throwing in a bunch of
> > > printks
> > > to see if things are being freed and set, to make sure this code
> > > is
> > > hit
> > > and something else isn't just corrupting it.
> > >   
> > 
> > Actually the patch does make the KASAN bug go away - I'm so used to
> > building without modules that I forgot to rebuild the module after
> > applying the patch, sigh.
> 
> I wasn't about to say anything. That's why I suggested adding printks
> and trying it again ;-)
> 

Yeah, when a simple printk doesn't work, you know there's something
idiotic going on.  Thanks for the tip ;-)

Tom

> -- Steve
