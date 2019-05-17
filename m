Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708EFC04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8D0205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DLcmwJ7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfEQDHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:07:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38413 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfEQDHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:07:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so2555394pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FZNWxHTVVazhA67ePeSz4ohY5K2eznCmCbVszKkx2ic=;
        b=DLcmwJ7nnYLQe72jJlkAUswlLL+NOQBPFn9y3+U2J4kLpsuMrsxRXrjd9aiVUuIJE2
         X3VLK5vbn3ZiG1JcjRhSpCKl+npdRGjtKBQ6osrSfcE0laytjtQfmvJMfjon6l6UjWi/
         bjqRGqA/+Wb8Ns2ysDJMuAmlBY07U8X2hDV9DPPGk8L4i0h/MVpEdTuPUccv879/2iMm
         g8CWMAjea6s4QK1OIUxL84j/NqwUJgzCgdMzqKq/X+bApDvU30p0J/uKkvoAWefMX54i
         AKB/Zke2oLMUJ+Og4U5F8a5awaDCc0E65eCbbh2HcYQx45RuIFuFRUIk8mgUOIZPJQDO
         RgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FZNWxHTVVazhA67ePeSz4ohY5K2eznCmCbVszKkx2ic=;
        b=b69P48N5e8IUBunJ/eKEYZmu6gMY5O5sRlnyME5h8bOG4OJKHATagGeG0ed4dECmzl
         Xq8NxBbWVPOaaONinM26HXD85HfAr4pBI3oeNHhZkhb9kBLJr5kgw/L8R7nlmSOTzkEz
         EneMlhJryTAlLEYhCI4bDqZdetPyfFo1yY1I3zdC7bvCf9V7G07mjflHXj4JX/o/cLbp
         0kZxeDB3PPcMx0avfjxa9D8FVK8C8xpvjdPmx7IbvRTcjdNdzai8VWqXzwGraWbZ1K/B
         SYa96lt22ef6WIfCreZmQrC+vWedp1/hBb8wQSCW5gfuNy2y/2vHMIDdiFBu5nHFYTAl
         n3OQ==
X-Gm-Message-State: APjAAAVTawdvg6jmYQHMFP5QgBsziy+MMero5Z+y0b+csDjydrkECw8p
        OHe/tzCua9JuHzHxBVqtZJHqNA==
X-Google-Smtp-Source: APXvYqxbrbT/9Hskd59wqO3wHnRWgHNYD5k/CuNpwGHBcIvTOn4QsIlcnQzYxve7UkaQYITC5nCPlA==
X-Received: by 2002:a62:5653:: with SMTP id k80mr57023417pfb.144.1558062429706;
        Thu, 16 May 2019 20:07:09 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id b32sm7377740pgm.87.2019.05.16.20.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 20:07:08 -0700 (PDT)
Date:   Thu, 16 May 2019 20:07:08 -0700 (PDT)
X-Google-Original-Date: Thu, 16 May 2019 20:05:15 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1 v2
In-Reply-To: <CAHk-=wiHtaVsbK4dZ79_h0R307Qv-Fdgdkp3SZ+F+QvzHHGrOQ@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-dd3bf038-f2d1-4318-af23-018200dd31af@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 19:17:17 PDT (-0700), Linus Torvalds wrote:
> On Thu, May 16, 2019 at 5:27 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.2-mw1
>
> Oh no no no.
>
> You're creating a binary file from your build or something like that:
>
>>  modules.builtin.modinfo                            | Bin 0 -> 46064 bytes
>
> which is completely unacceptable.
>
> I have no idea what you're doing, but this kind of "random garbage in
> git commits" is not going to fly. And the fact that you're adding
> random files really means that you are doing something *horribly*
> wrong.

Sorry, I have no idea how I missed that.  It looks like I managed to screw
something up while trying to fix up that patch, but I'm not really sure what I
did.  I'll try to figure out how to not screw it up next time.

Thanks for catching this!
