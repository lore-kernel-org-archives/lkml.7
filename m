Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10105CA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D339020663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqhQDfcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfJ2IHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:07:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44120 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfJ2IHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:07:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so12487337wro.11;
        Tue, 29 Oct 2019 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GfXU1iwRgOcekEGBFraoPf4Q3S7itjMXcEa/+TYa5iQ=;
        b=sqhQDfcDyYknLPZL9eGIlv4PJfvAw+LP1NkwTn3IgkDJzjVpzmxyzW7JFEl4rLbo9Y
         /R2X8JAiBJwH/jg+sveDNJujfhQR79QDlqW75iHGJoJHRH+oVcmeA2hcEGkHnnQC1TS5
         Ez9Kh2Pn+UrfGVJesdrvpHCWpBOTLXCDqrGidoRHNad49mbdnYuqeI2eMJvPQEvL21Il
         ia4o/uD52xrnG0H7X9zxbA78YsBcC9CNRBu6Jr412ivrS7kNAyEzmAwgfhQr2tUus+hL
         TewCCGy1mgX9tlFUUSSqQHSQEQ7FFg8/QBuEo3Wp0ayRJd2JISSXMFZYsBCObiTkau0m
         11zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GfXU1iwRgOcekEGBFraoPf4Q3S7itjMXcEa/+TYa5iQ=;
        b=JJCulrNaS0Y04IHwA2aWhiZRZYOSQKhOTHVOlsgYXrWtkudH0hjYSZbQf+xg6YtEvM
         0/FR0+oniEOu2z0oI3VofUKUHvJcr/s24uUlr9TfI5/eFOOwf36mAVOLK3rxyW7qKGnY
         EBkiHKntJdotqe0jNrsePSiqlxmX94clhceKG1eHmp49onm/RCX1Jj1NvEQJatytR2IL
         HHZKcuCs8IXZxMhIXaBTJL5hi9raKeYhKnZXMKKweZJCDWDyWOzIPUFbZoma9Tk2gBXi
         FhKS/jawxqspXtWpST6Wmd2J9may73NyPmH9RH3BFIf1s7pi80AspwUaJUZdJzicqoDu
         bLAQ==
X-Gm-Message-State: APjAAAVG81QtO2CF/pcN8GD83Z7hAsDrWjhZW+kxNCXiA/V/CIsxTeKU
        axZhZjZR05/BUF8yg/PQOV0=
X-Google-Smtp-Source: APXvYqygyU6rn4vt9zUjs90G5fyqFX/x5yrUMsrVZ6NmKw41MJksTZW+YcXsjt6oTkWlvCrjP8R0MQ==
X-Received: by 2002:a5d:4047:: with SMTP id w7mr18366744wrp.270.1572336423968;
        Tue, 29 Oct 2019 01:07:03 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:c1a7:4ac0:2d11:a4f8])
        by smtp.gmail.com with ESMTPSA id o15sm13468325wrv.76.2019.10.29.01.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 01:07:03 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:07:01 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-sparse@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Message-ID: <20191029080701.qpvscbz3xptadhbd@ltop.local>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
 <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
 <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
 <20191028221523.vlzdk6dkcglxei6v@desk.local>
 <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
 <20191028230349.xlhm42ripxktx43y@desk.local>
 <61eb73ad-5c30-0005-5031-6584df72ad5f@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61eb73ad-5c30-0005-5031-6584df72ad5f@ramsayjones.plus.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 02:38:54AM +0000, Ramsay Jones wrote:
> On 28/10/2019 23:03, Luc Van Oostenryck wrote:
> > diff --git a/parse.c b/parse.c
> > index 4464e2667..4b0a1566c 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -345,6 +345,7 @@ static struct symbol_op goto_op = {
> >  
> >  static struct symbol_op __context___op = {
> >  	.statement = parse_context_statement,
> > +	.attribute = attribute_context,
> 
> Hmm, so why is do we have a context_op and a __context___op?
> 
> >  };
> >  
> >  static struct symbol_op range_op = {
> > @@ -537,6 +538,7 @@ static struct init_keyword {
> >  	{ "while",	NS_KEYWORD, .op = &while_op },
> >  	{ "do",		NS_KEYWORD, .op = &do_op },
> >  	{ "goto",	NS_KEYWORD, .op = &goto_op },
> > +	{ "context",	NS_KEYWORD, .op = &context_op },
> >  	{ "__context__",NS_KEYWORD, .op = &__context___op },
> 
> So, can '__context__' be used in a statement, as well as an
> attribute, while 'context' can only be used in an attribute?

Yes, indeed.
'__context__' was only parsed as a statement and 'context'
only as an attribute. But now we also want to be able to use
'__context__' as an attribute (because 'context' is not a
reserved keyword and can thus be a used defined macro).

There is no reason, though, we should now also want to use
'context' as a statement since it's a sparse extension. Hence
adding attribute_context to '__context___op' and keeping
'context_op' as such (but moving them together).

-- Luc
