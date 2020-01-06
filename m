Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE9C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC892467F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="IjaLXYIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgAFSk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:40:59 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:50968 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgAFSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:40:57 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 7F188683B63;
        Mon,  6 Jan 2020 19:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1578336055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rp8CUrnWGAoX8TC2iOuIG764rbPn2mqZv/jvq2or5Tk=;
        b=IjaLXYIRwuSSDDoP3AEQkfXkT3M26EZ/9Lfh+wD7HcqyriyPvB5UuIPxmJ7a2JCitX5e1+
        GFvUj6Xs95xNou34pU8rzc0T6QijPfQ/KyFAkdxDXlCrdtswZMRz8caBzjUWzGMO34qRMK
        CZuYApNwruZvaodV0MuczD4YHq4f/t0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Jan 2020 19:40:55 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: Multidevice f2fs mount after disk rearrangement
In-Reply-To: <20200106183450.GC50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
 <2c4cafd35d1595a62134203669d7c244@natalenko.name>
 <20200106183450.GC50058@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <ee2cb1d7a6c1b51e1c8277a8feaafe6d@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 06.01.2020 19:34, Jaegeuk Kim wrote:
> Thank you for investigating this ahead of me. :) Yes, the device list 
> is stored
> in superblock, so hacking it manually should work.
> 
> Let me think about a tool to tune that.

Thank you both for the replies.

IIUC, tune.f2fs is not there yet. I saw a submission, but I do not see 
it as accepted, right?

Having this in tune.f2fs would be fine (assuming the assertion is 
replaced with some meaningful hint message), but wouldn't it be more 
convenient for an ordinary user to have implemented something like:

# mount -t f2fs /dev/sdb -o nextdev=/dev/sdc /mnt/fs

Hm?

-- 
   Oleksandr Natalenko (post-factum)
