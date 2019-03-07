Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7792CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D742064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="XrbmO7Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCGCo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:44:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35732 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCGCo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:44:57 -0500
Received: by mail-io1-f65.google.com with SMTP id x4so12154715ion.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 18:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=3fDLRdafMCEeumCNQkE60+ioul4UnOCzLjX/tyLBlfA=;
        b=XrbmO7TnUeEKuBKYXwZQE5ynbrdkQGPlqqbDW7Z6pjtjbo+9yUcBPzmwxhINY8QIR7
         srM9tEuoHfZoeRdkAiZbSLM+ms5IrMtykkSrvoG/M9mzy2GjxABO6lUFt88t3XaxWrRl
         NxOcgr7BRIRPXal2hxpTVi9ZjaugNx4jV9sbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3fDLRdafMCEeumCNQkE60+ioul4UnOCzLjX/tyLBlfA=;
        b=Fjg4Kw8eBtLhu8BpTYTpiFvR+yY1ScTcJnYI5ysvO4FC+Jqz0gYP9hu3UiYtdKLTt2
         cCwJNiwEymvHiC2bPkqaiAFW5J2tdJY/C9FXvrI0njNseM+i91qih700Pq7rbTw/PjZX
         tjgfCx1JlvAEGTyqgvK9kS3UFpV3v0gASk1EGnpTW3yeFOg8V/3Syq4nWM0qjGvyOlP/
         cpjCa/i7bn3uGQXZhib6Mhg9NypEvIcV5Q1ut55GVHP44Hxy9ACkCIjY/EGHpuxjNUr6
         skLJ7pSXNBNgYURWWsYZ7+QTBFJRJNPrSm4xvZ5ynharkgGKLbcV7j+OVoMGnaZ8YPaS
         KN0w==
X-Gm-Message-State: APjAAAWFTgKb0AUB4m3GmdFTL+HNo4kC4NsB7x8fVulPKTQXDFvQJ9v5
        FGNm/wqTWusS6MajwNRNdkgQrg==
X-Google-Smtp-Source: APXvYqxnH4SbrA3pyHAyYpFJHpba1bF4m9iYTMRYUKTfL8zT/opzqecitOdv85rpMaQNobwS6HyuWA==
X-Received: by 2002:a5e:d501:: with SMTP id e1mr5211377iom.149.1551926696258;
        Wed, 06 Mar 2019 18:44:56 -0800 (PST)
Received: from ?IPv6:2600:1700:c991:2dc0::64? ([2600:1700:c991:2dc0::64])
        by smtp.googlemail.com with ESMTPSA id q5sm1202435ioh.22.2019.03.06.18.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 18:44:55 -0800 (PST)
To:     Jan Kara <jack@suse.cz>, pali.rohar@gmail.com, reinoud@netbsd.org
Cc:     Colin King <colin.king@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
From:   Steve Magnani <steve.magnani@digidescorp.com>
Subject: [RFC] udftools: steps towards fsck
Message-ID: <17e5fea5-8d76-c96d-8902-9050acba4288@digidescorp.com>
Date:   Wed, 6 Mar 2019 20:44:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Please remove at least LKML when responding. Mailing lists are a 
scattershot attempt to reach others who might be interested in this 
topic since I'm not aware of any linux-udf mailing list. )

A few months ago I stumbled across an interesting bit of abandonware in 
the Sourceforge CVS repo that hosted UDF development through about 2004. 
Code that originated here eventually became the modern-day udftools:

     https://sourceforge.net/p/linux-udf/code/

The 'udf' module in that repo contains a program from 1999 named 
'chkudf', which appears to have been written by Rob Simms. Being from 
the Y2K era, the program has no awareness of anything beyond UDF2.01; in 
particular, its comprehension of VAT reflects UDF1.50 and not the 
revamped design introduced in UDF2.00. But it does have an ability to 
analyze the major UDF data structures and to walk the filesystem.

I've spent quite a bit of time enhancing and fixing bugs in this code, 
with a short term goal of being able to report damage to UDF2.01 
filesystems on "hard disk" (magnetic and SSD) media. It's not quite to 
the point of being release-ready, but I think the code is on the cusp of 
becoming useful to others so I wanted to get some feedback on the approach.

I posted a GIT port (via SVN) of the CVS repo here, including all the 
changes I've made so far:

     https://github.com/smagnani/chkudf.git

If you're interested in building the code you should be able to just run 
'make' within the chkudf folder. On Debian-derived systems you'll need 
libblkid-dev installed in order to build.

Some questions for consideration:

* Would a udffsck limited to checking of UDF2.01 and earlier on "hard 
disk" media be a sufficiently useful starting point to justify inclusion 
in udftools? Obviously a tool with such limitations would have to be 
particularly vigilant about ensuring that media-under-test doesn't 
exceed its capabilities.

* If so, do you think the chkudf implementation could qualify? It's not 
ready yet, but with an investment of some time and energy it could be 
made more functionally complete and (maybe more importantly) more 
user-friendly.

In part this is a question of whether the chkudf design can support 
enhancements to get (eventually) to UDF2.60 and optical media support, 
balanced against the many years without an open-source udffsck and not 
"letting the perfect become the enemy of the good."

* For any standards-based parser it's important to have examples of as 
many variations as possible (both normal and pathological) in order to 
ensure that corner cases and less common features are tested properly. 
Can anyone point me to any good sources of UDF data for testing? There 
are always commercial DVDs and Blu-Ray discs, of course, and I've 
cobbled together a few special cases by hand (i.e., a filesystem with 
directory cycles), but I have no examples with extended attributes or 
stream data. If I could find a DVD of Mac software in a resale shop 
would that help? [Side note, I've thought of enhancing chkudf to support 
a tool that would store all the UDF structures of a filesystem in a 
tarball that could be used to reconstitute that filesystem within a 
sparse file. Since none of the file contents would be stored the 
tarballs would be relatively small even if they represent terabyte-scale 
filesystems.

* Are there versions (or features) of UDF that are less important to 
support than others (1.50? Strategy 4096? Named streams? etc.) I know 
1.02, 2.01, and 2.50 are in wide use.

* What kinds of repairs are most important to implement? I was thinking 
that regeneration of the Logical Volume Integrity Descriptor and the 
unallocated space bitmap are both important and hopefully relatively 
straightforward. Beyond that...recovering ICBs to "lost+found"?


My 2 cents:
I didn't write this program. There are things I would have done 
differently, but to this point I have tried to work within the existing 
design and code style. After becoming more aware of differences between 
the various UDF standards (in particular, the increase in complexity 
since 2.01) and the many errata involved, I have a gut feeling that an 
implementation in a language that supports inheritance might be a lot 
more manageable over the long term - but it's not something I've spent a 
lot of time thinking about. I've only recently become aware of 
UDFclient, and haven't had time to look over its design yet. And, I can 
see the potential for followon utilities such as a filesystem resizer - 
which might argue for making more of the code library-based and not so 
heavy on printed output.

Bottom line...udffsck has to start somewhere, could it start with chkudf?

Thanks for reading.
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

