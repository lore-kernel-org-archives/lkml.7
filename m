Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5FCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 11:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9963222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 11:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzVvXOwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfJSLo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 07:44:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46777 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJSLoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 07:44:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so6600305lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6HRz68HiFzZlP3tRHK3yJFb4gohgu9mfexY7/E4XFuo=;
        b=dzVvXOwNZVEhQAT3J19DzsIwKiOGDrNfX6yeD5enDt8ABHfAC68SibKoY9Aswoz1rO
         HGcJ1bXQtHQURP9YqelyPplOWP2VK+4MvYz3bQZ3Kkqo7dM22VaICh624eO0fgxVW9n/
         9GnjK2P9hCaOwmOSF+cQXL/gaOGiwrpiXdqZiY2tuh1pXw0HYbWRb2g+vRRuGZrcGwKz
         p8CtoN+O44120d9Y53S/6Dgf+xPLPcC4/2Cb+uULInzvyltZxKzDTf5zkeWFOmJBjhNz
         D83QY6s1eZjSszzwM+dWQ93nd25YOlVCkN5W5ae/ylgfgcNzWqiqsyWE12/2Y+XTLz6Z
         Ar/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6HRz68HiFzZlP3tRHK3yJFb4gohgu9mfexY7/E4XFuo=;
        b=kmi+W2MY9B+76HicuULAV+EJM1uhut+b4H/+6PIVikgllC5mNkN1t7WPGn8/juN6Do
         ji6OuzIJJY/m8XlUnPM1ZkxBjwUi2hvqAqhwSDbYzyiOp0NvRO1KQkPVYIg0AUZN5uxD
         pHF3usKryPG6ESvVX85XmB8grbG2K6NdhksfEEPrzXBOfkpAaW/Z7f27snVOjz08GDgk
         orVMVreLQjFeeJJkDyWBMw8IqqWFD4G76fMbb91k77Wz3whrWRW6iB/86ACttZh350pT
         9e8E7tbhPtrZn1JgGAuCXfGp2GfYT2id8yM6AsRpGmM2lfO4Dx5LTloaYO06wH1Tlh3W
         8AGg==
X-Gm-Message-State: APjAAAUXzKifvhPokAAEvw4FeeVUZ6A9Cw2LKCWS9m4XzGIudkC1xhnl
        tn8H43qdP3ZV5qYnFlsm31xTKc/u9a0=
X-Google-Smtp-Source: APXvYqxasR8A21Fxv3CR/wZsNTUdZdw8jBooa+ZPVxia1U6TFwp7bZXJ0aHPSjwwj1EBSIbfqgb5ag==
X-Received: by 2002:ac2:5542:: with SMTP id l2mr8769192lfk.119.1571485463481;
        Sat, 19 Oct 2019 04:44:23 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id e7sm3905877lfn.12.2019.10.19.04.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 04:44:22 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id DDA7E460CFB; Sat, 19 Oct 2019 14:44:21 +0300 (MSK)
Date:   Sat, 19 Oct 2019 14:44:21 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [BUG -tip] kmemleak and stacktrace cause page faul
Message-ID: <20191019114421.GK9698@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I'm not sure if I've CC'ed proper persons, so please sorry if I did.
Anyway, today's -tip (07b4dbf1d830) refused to boot

[    0.024793] No NUMA configuration found
[    0.025406] Faking a node at [mem 0x0000000000000000-0x000000007ffdefff]
[    0.026462] NODE_DATA(0) allocated [mem 0x7ffdb000-0x7ffdefff]
[    0.027246] BUG: unable to handle page fault for address: 0000000000001ff0
[    0.028160] #PF: supervisor read access in kernel mode
[    0.028992] #PF: error_code(0x0000) - not-present page
[    0.029820] PGD 0 P4D 0 
[    0.030226] Oops: 0000 [#1] PREEMPT SMP PTI
[    0.031069] CPU: 0 PID: 0 Comm: swapper Not tainted 5.4.0-rc3-00258-g07b4dbf1d830 #93
[    0.032317] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[    0.034163] RIP: 0010:get_stack_info+0xb3/0x148
[    0.034903] Code: 04 d5 84 48 01 82 66 85 c0 74 25 8b 0c d5 80 48 01 82 0f b7 14 d5 86 48 01 82 48 01 f1 89 13 48 01 c8 48 89 4b 08 48 89 43 10 <48> 8b 40 f0 eb 2b 65 48 8b 05 1f f4 f9 7e 48 8d 90 00 c0 ff ff 48
[    0.037579] RSP: 0000:ffffffff82603be0 EFLAGS: 00010006

I nailed it down to the following kmemleak code

create_object
  ...
  object->trace_len = __save_stack_trace(object->trace);

if I drop this line out it boots fine. Just wanted to share the observation,
probably it is known issue already.

Sidenote: The last -tip kernel which I've been working with is dated Sep 18
so the changes which cause the problem should be introduced last month.
