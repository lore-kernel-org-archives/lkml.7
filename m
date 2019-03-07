Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB62C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085F20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooB7eI8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfCGKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:23:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:23:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id c13so6393045wmb.0;
        Thu, 07 Mar 2019 02:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HrrVBsxFyLwBuncur9okJNCjKX3TcQI8oRuE8m58v7M=;
        b=ooB7eI8Mav+1kOC6iZ15r1EHrOl5UFasbjSLDOwGAnhZve2N9TnYq9hSvmKUp6YNUX
         U/wBsWtkNWajtsPl5U7c8KM23wERvVAM4CoRy0kSoMu61pTgv96WVq5G11LDD5jW8tkE
         gdXFFL54FbGXwOMf2qc4DpBpslip9Bt2MFS15iCejMo86ME5CUrPI+3atdBfR45GC9II
         SejxCXfFhQd0+JmNTPKBPbEEQ7YDE/eWUarDP34dmKhDEb7DFdWc8Hopkd0DglUdL8u7
         mmIC1t9fpGDohn23HKdigXD7ypra9zpjwNQWS9jx7YSH8BcxK/pL0HbkqzbY0D05G0oa
         xC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HrrVBsxFyLwBuncur9okJNCjKX3TcQI8oRuE8m58v7M=;
        b=aMpkzgjwCg7VPbRqZchPslNmEyyA+kleU+YBqAqbutSJnPbSkqdd1hecGgDp7rs4QB
         VvhOCKwWPzP3aMr436k/zU6KSBAx5G2o3UGj9+vonWt5Xujc6Rosg6G6z2JinDEA2Rgr
         Y2FZBVlbw8BtKNtILXHPJZPpUQTFnFPsgUJhgfiR/bygDW7pQuQWXkyAvNEpz1P7uetw
         Kjg89JxUQ/VxB1FOfJYmSKBroHBlfYmDcYuatc3GFsVY3+yvzk6foOQ+jvvwpOOUIw/J
         +Fx1NIFpBpysuMpoEMvAXvxWkvaS+ijz3+3/YXDV4kzNGqalkX2T4+4ahrvF79lAWWho
         HBXw==
X-Gm-Message-State: APjAAAWvCEA2EqJEzrN6eKh7SkA8hSbuLD89poYdXm8kj4Hwj8QoDaHL
        nRYrQC2+kJsVsvkDDHqIwos=
X-Google-Smtp-Source: APXvYqzTYm+sDiNrU0Ph7bvXF3CzUVJmMZ2E7Ar+s5UVVbODpSqJoqqohkk5RBTHzL5Qsq7UZmcY7w==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr4989016wml.17.1551954231268;
        Thu, 07 Mar 2019 02:23:51 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k20sm4847559wre.41.2019.03.07.02.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 02:23:50 -0800 (PST)
Date:   Thu, 7 Mar 2019 11:23:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>, reinoud@netbsd.org,
        Colin King <colin.king@canonical.com>,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <vojtech.vladyka@foxyco.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] udftools: steps towards fsck
Message-ID: <20190307102349.q5not23mve2soope@pali>
References: <17e5fea5-8d76-c96d-8902-9050acba4288@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17e5fea5-8d76-c96d-8902-9050acba4288@digidescorp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 March 2019 20:44:54 Steve Magnani wrote:
> (Please remove at least LKML when responding. Mailing lists are a
> scattershot attempt to reach others who might be interested in this topic
> since I'm not aware of any linux-udf mailing list. )

IIRC there is no linux-udf mailing list, but I do not see any reason why
not to use linux-fsdevel or linux-kernel.

> A few months ago I stumbled across an interesting bit of abandonware in the
> Sourceforge CVS repo that hosted UDF development through about 2004. Code
> that originated here eventually became the modern-day udftools:
> 
>     https://sourceforge.net/p/linux-udf/code/

udftools project was moved to github:
https://github.com/pali/udftools/

Ben (original project developer) also updated sourceforce page and you
can see there a big blue box "This project can now be found here." which
points to github.

> The 'udf' module in that repo contains a program from 1999 named 'chkudf',
> which appears to have been written by Rob Simms. Being from the Y2K era, the
> program has no awareness of anything beyond UDF2.01; in particular, its
> comprehension of VAT reflects UDF1.50 and not the revamped design introduced
> in UDF2.00. But it does have an ability to analyze the major UDF data
> structures and to walk the filesystem.

As project page was moved to github I converted also whole source code
history. You can find there also that that old chkudf code...

https://github.com/pali/udftools/tree/87acf1a2306b7b60ed9d61b53c2a487ea5f3396c/src/chkudf

But, I would like to let you know that Vojtěch (CCed) started working on
udffsck implementation as part of his master thesis and current WIP code
is available on github in pull request:

https://github.com/pali/udftools/pull/7

So it would be great if you look at new code and probably help Vojtěch
to finish new effort as trying to port and fix 20 years old code which
was already removed from udftools project...

> I've spent quite a bit of time enhancing and fixing bugs in this code, with
> a short term goal of being able to report damage to UDF2.01 filesystems on
> "hard disk" (magnetic and SSD) media. It's not quite to the point of being
> release-ready, but I think the code is on the cusp of becoming useful to
> others so I wanted to get some feedback on the approach.
> 
> I posted a GIT port (via SVN) of the CVS repo here, including all the
> changes I've made so far:
> 
>     https://github.com/smagnani/chkudf.git
> 
> If you're interested in building the code you should be able to just run
> 'make' within the chkudf folder. On Debian-derived systems you'll need
> libblkid-dev installed in order to build.
> 
> Some questions for consideration:
> 
> * Would a udffsck limited to checking of UDF2.01 and earlier on "hard disk"
> media be a sufficiently useful starting point to justify inclusion in
> udftools? Obviously a tool with such limitations would have to be
> particularly vigilant about ensuring that media-under-test doesn't exceed
> its capabilities.
> 
> * If so, do you think the chkudf implementation could qualify? It's not
> ready yet, but with an investment of some time and energy it could be made
> more functionally complete and (maybe more importantly) more user-friendly.
> 
> In part this is a question of whether the chkudf design can support
> enhancements to get (eventually) to UDF2.60 and optical media support,
> balanced against the many years without an open-source udffsck and not
> "letting the perfect become the enemy of the good."
> 
> * For any standards-based parser it's important to have examples of as many
> variations as possible (both normal and pathological) in order to ensure
> that corner cases and less common features are tested properly. Can anyone
> point me to any good sources of UDF data for testing? There are always
> commercial DVDs and Blu-Ray discs, of course, and I've cobbled together a
> few special cases by hand (i.e., a filesystem with directory cycles), but I
> have no examples with extended attributes or stream data. If I could find a
> DVD of Mac software in a resale shop would that help? [Side note, I've
> thought of enhancing chkudf to support a tool that would store all the UDF
> structures of a filesystem in a tarball that could be used to reconstitute
> that filesystem within a sparse file. Since none of the file contents would
> be stored the tarballs would be relatively small even if they represent
> terabyte-scale filesystems.
> 
> * Are there versions (or features) of UDF that are less important to support
> than others (1.50? Strategy 4096? Named streams? etc.) I know 1.02, 2.01,
> and 2.50 are in wide use.

Currently udftools support UDF revisions 1.01, 1.02, 1.50, 2.00, 2.01
and for BD-R (without metadata partition) also 2.50 and 2.60.

> * What kinds of repairs are most important to implement? I was thinking that
> regeneration of the Logical Volume Integrity Descriptor and the unallocated
> space bitmap are both important and hopefully relatively straightforward.
> Beyond that...recovering ICBs to "lost+found"?
> 
> 
> My 2 cents:
> I didn't write this program. There are things I would have done differently,
> but to this point I have tried to work within the existing design and code
> style. After becoming more aware of differences between the various UDF
> standards (in particular, the increase in complexity since 2.01) and the
> many errata involved, I have a gut feeling that an implementation in a
> language that supports inheritance might be a lot more manageable over the
> long term - but it's not something I've spent a lot of time thinking about.
> I've only recently become aware of UDFclient, and haven't had time to look
> over its design yet. And, I can see the potential for followon utilities
> such as a filesystem resizer - which might argue for making more of the code
> library-based and not so heavy on printed output.
> 
> Bottom line...udffsck has to start somewhere, could it start with chkudf?
> 
> Thanks for reading.
> ------------------------------------------------------------------------
>  Steven J. Magnani               "I claim this network for MARS!
>  www.digidescorp.com              Earthling, return my space modulator!"
> 
>  #include <standard.disclaimer>
> 

-- 
Pali Rohár
pali.rohar@gmail.com
