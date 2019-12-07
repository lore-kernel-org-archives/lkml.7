Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58730C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E324670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="jSli4jXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLGRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:34:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40236 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:34:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so4035575plp.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tPWpSnwJ2COIRhD9qb77po5FOe0i3trGmFgluWtfyyI=;
        b=jSli4jXDgNnaJy+iRKywzdvnk6EOhsjOwG0Lf5T+fJYaWCOj2yzYpqzGtdMXUM0np6
         mtHAnme/N43DM5yKZKTEKFzRa9ny8XoQ2AGlaxMAnoZXPRsto5uhJrHhtylhPBWA/cyh
         H2fMLVyRpzr6f+9s7DQpmdYgQx3c1T2G4z4y2pJJGbYIHQN61op0PeTkE6jXJrWV3LMq
         pT3dSeQg2XNA58VmoyQJ/AeUvhEfcQ3SAxg7gVnKV9fAaTjfDtoveNeikrw1FFmu5kMV
         qjki+3fWgjaMc5fByVsDAqR2gnRTaIi5xcUZQjLSOmNxIMxx+n2JbzJRexwNh3OTmNgM
         TQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tPWpSnwJ2COIRhD9qb77po5FOe0i3trGmFgluWtfyyI=;
        b=mcA6Xfn4rODqDO/vTBwONYmwlgMTcJTJG8hshOHPFcJgnP8rGDXacNJcWRdax1bgw2
         lWEgvz2R83mg22EpeE1zB8qQboJanvf2HXFF2E69jlF9EVmcEhcj2D1q4u3xh9asd3KR
         9lObz6avVfcV89gezXF77C1qRIXPMD1A4pKPXN8HrjpYR4BYOAWIQhA7wgDSkRG9LLqb
         ca4eMgoblYUWBD3FKRNJ2WyoIdO7dJ9kROOJ8VYFQ0oc8mESqfdG39UJOasDIWaTnNUD
         kp7GeLiBAO/sJcmn1Wmzwsxs6WgQnuZR3YdmbvrcN4qiMQxA7BddtLCUpWqR6AxybGq9
         40Sg==
X-Gm-Message-State: APjAAAVpsBOe9GvrYO7mF9W464tM9RWFk4cATwDJBB2c1I+a2r1n8xHQ
        liV9NrbYIeNoFBwjrsM7tfUYbA==
X-Google-Smtp-Source: APXvYqyjffLJTjWelmui7B6GTt8oKp0HoxP98kQhATKXEaIb5Zsc6WZeEBR1JoWAD5vvrXNKdeKQ/g==
X-Received: by 2002:a17:902:830b:: with SMTP id bd11mr20191188plb.317.1575740067449;
        Sat, 07 Dec 2019 09:34:27 -0800 (PST)
Received: from debian ([122.164.203.149])
        by smtp.gmail.com with ESMTPSA id w11sm15981912pfn.4.2019.12.07.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 09:34:26 -0800 (PST)
Date:   Sat, 7 Dec 2019 23:04:20 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PROBLEM]:  WARNING: lock held when returning to user space! (5.4.1
 #16 Tainted: G )
Message-ID: <20191207173420.GA5280@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

i got the following  output related from typical dmesg output from 5.4.1 kernel

================================================
WARNING: lock held when returning to user space!
5.4.1 #16 Tainted: G            E    
------------------------------------------------
tpm2-abrmd/691 is leaving the kernel with locks still held!
2 locks held by tpm2-abrmd/691:
 #0: ffff8881ee784ba8 (&chip->ops_sem){.+.+}, at: tpm_try_get_ops+0x2b/0xc0 [tpm]
 #1: ffff8881ee784d88 (&chip->tpm_mutex){+.+.}, at: tpm_try_get_ops+0x57/0xc0 [tpm]


--
software engineer
rajagiri school of engineering and technology
