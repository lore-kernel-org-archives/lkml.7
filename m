Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DEAR_SOMETHING,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8616AC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5764320672
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plexistor-com.20150623.gappssmtp.com header.i=@plexistor-com.20150623.gappssmtp.com header.b="f/OICRwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKNOCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:02:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35198 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKNOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:02:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id r16so5101538edq.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=33PAA6r/k9VRl85H/xVoKlwt8JinRmzAIvZM9Tx3pHM=;
        b=f/OICRwApIEBHjzK35OPs5SjQEx99JZRNDxNPjSkxXcz9WGT2l65dn755c5UPYn05M
         JFgCFMSPOhrZRBfSZsTG28mPgbilqm9oG2mlKVUq2iR/rcov8bVWHeXZnljQXeuiTdB4
         pc06r27kyk/A/00uVugzmOyIslqS7zYSYV1UWmiuaN0o9WmOlEi7pL/2cmpRH20so0Ai
         wNIR4AoXXVHdmtuvXhPmkSibGhA1hesN9O27yFlcKXGe12lMcY5zjgkaVURlm2uphgtj
         w/BYnKJvPHVttb0P63EU+NI7FSMl4ugLBiydhXllOGOZSTDRnL0PhyknOXXwqzFu+PBM
         ptzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=33PAA6r/k9VRl85H/xVoKlwt8JinRmzAIvZM9Tx3pHM=;
        b=Du4/iCxFDp9dngvAgxuNEGAWAwmtDiDZw7x/qBP5f3ahcLaPiWMq96JUX7jwJDYegJ
         +9CgWMiKHpgrEqtsPVbgTab5aN/OyBKuyhOXLWttK2Tn7f/VljGE5WZggg0MU5WxJh9U
         QhHNElN+cK6I8UFxdYaFRCBm2pz4UhyIWp74Ke8GWSgzs4gcoGZHy6zHsLx0GzReR7Fr
         r1d7BEaBbc+lQHIJtR1wl03x5fvPnG12uVH1/xNe8hEiG1i0MSJ6qIOQ2Lq8NAggI3C6
         ytS7eTSr1YkVahZ0G41HcNacT/mfKERPPU8Aa2YisllToUKwJcJyET40I+bmDayEKrtW
         Mhag==
X-Gm-Message-State: APjAAAUduwr3NHQk7cRH6ldWpEEljFLNPHQZp8Fgoq6nuHwK3co7luX8
        WXPynfF3JVIQCHig79jLPPj1049FgWs=
X-Google-Smtp-Source: APXvYqxsR3NNaXQDvYGd12/9s3QWnCadEINpEzkufZiFdqDh7qo1v2EMXTobGwnwhSwWcVV4VH6UqQ==
X-Received: by 2002:a17:906:3019:: with SMTP id 25mr8627056ejz.280.1573740137638;
        Thu, 14 Nov 2019 06:02:17 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id j23sm66197ede.52.2019.11.14.06.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:02:16 -0800 (PST)
Subject: Re: Please add the zuf tree to linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
 <20191024023606.GA1884@infradead.org>
 <20191029160733.298c6539@canb.auug.org.au>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <514e220d-3f93-7ce3-27cd-49240b498114@plexistor.com>
Date:   Thu, 14 Nov 2019 16:02:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029160733.298c6539@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 07:07, Stephen Rothwell wrote:
> Hi Christoph,
> 
> On Wed, 23 Oct 2019 19:36:06 -0700 Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Thu, Oct 24, 2019 at 03:34:29AM +0300, Boaz Harrosh wrote:
>>> Hello Stephen
>>>
>>> Please add the zuf tree below to the linux-next tree.
>>> 	[https://github.com/NetApp/zufs-zuf zuf]  
>>

Sorry for the late response was very sick for a few weeks, now doing better

>> I don't remember us coming to the conclusion that this actually is
>> useful doesn't just badly duplicate the fuse functionality.
> 

Dear Sir Christoph

ZUFS is not at *all* a duplication of the FUSE functionality. In fact they are
almost completely complementary. The systems that would benefit from fuse would
do poorly under zufs. And the systems that benefit from zufs do very *very* poorly
under fuse.
From the get go I have explained on the mailing list and to the guys that a fuse
replacement would just be a waist of time. That those async in nature, need page-cache
not sensitive to latency Systems are better with fuse. And those Systems that need
very low latency, zero copy, sync operations, highly parallel will do very poorly under
fuse and we need to invent a new multy-dimentional wheel to address those.

ZUFS was never a "better-fuse". It was from the get go a different animal to address
systems and demands that are not possible under fuse.

ZUFS is also (as opposed to fuse) A new way to communicate with User-mode servers, not
necessarily FileSystems. It does implement the full FileSystem API but any server, Say
MySQL under ZUFS will benefit from a low-latency, throughput and parallelizm unseen
before. This is because at the core it is a zero-copy synchronous IPC between applications.

And specially it is good with pmem. A pmem-only (NvDIMM based) FS running in user mode
gives me *better* results then XFS-DAX in Kernel. Now how is that possible?
(Under a zufs ported pmfs2)
I guess we did not do such a "BAD" job as you were so happily declaring.

The Linux Kernel was always about choice and diversity. There is a very respectable
place for both fuse and zufs side by side tackling different workloads and setups.
In fact, for example, EXT4 and XFS have 95% overlapping functionality. But we both know
that those places where XFS is king EXT4 can't get close, Yet there are still places that
EXT4 does better then XFS, such as single local disk, embedded systems, lighter wait ...
ZUFS and FUSE have maybe at the most 20% over lap in functionality. They are not even
cousins.

So please why do you make such bold statements, which are not true. And clearly you
have not studied the subject at all. I do not remember you ever participated at one of
my talks? Or gave your opinion on the subject, since the 2 years I have first sent
the RFD about the subject. (2.5 years)

At the last LSF. Steven from Red-Hat asked me to talk with Miklos about the fuse vs zufs.
We had a long talk where I have explained to him in detail How we do the mounting, how
Kernel owns the multy-devices. How we do the PMEM API and our IO API in general. How
we do pigi-back operations to minimize latencies. How we do DAX and mmap. At the end of the
talk he said to me that he understands how this is very different from FUSE and he wished
me "good luck".

Miklos - you have seen both projects; do you think that All these new subsystems from ZUFS
can have a comfortable place under FUSE, including the new IO API?
Believe me I have tried. I am a most lazy person. I would not have slaved on ZUFS for
2 years if it was a "badly duplicate the fuse functionality". Why would I?

Latest fuse already took some very good ideas from ZUFS. We believe this is a very good
project to have in the Kernel with new innovation.

But Dearest Christoph. I have learned to trust your "guts" about things. Please look
deeper into the subject (Perhaps review the code) and try to explain better what are your
real concerns. Perhaps we can address them?

> So is that a hard Nak on inclusion in linux-next at this time?
> 

I do not see what is the harm to anyone if it is to be included in linux-next?
Would you please help me in testing and stabilizing a very serious and ambitious project.
That has merit and is used by clients. I believe it is a very low risk project for the reset
of the Kernel. If not we can remove it very fast.

Cheers
Boaz
