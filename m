Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC4E214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfLLLFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:05:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46575 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:05:22 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ifMHT-000766-AO; Thu, 12 Dec 2019 11:05:15 +0000
Date:   Thu, 12 Dec 2019 12:05:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>, qiwuchen55@gmail.com
Cc:     qiwuchen55@gmail.com, peterz@infradead.org, mingo@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] kernel/exit: do panic earlier to get coredump if global
 init task exit
Message-ID: <20191212110513.qf2sapgggnp46voc@wittgenstein>
References: <1576131255-3433-1-git-send-email-qiwuchen55@gmail.com>
 <20191212095127.GA5460@redhat.com>
 <20191212100838.GB5460@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212100838.GB5460@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:08:38AM +0100, Oleg Nesterov wrote:
> can't you use is_global_init() && group_dead ?

Seems reasonable.
Looks like we can move
group_dead = atomic_dec_and_test(&tsk->signal->live);
further up...

(Ideally I'd like to have a test for this to ensure that this lets you
capture a global init coredump but that might be tricky. But since you've
seem to have run into this case maybe you even have something that could
be turned into a test? (Similar to how we already have a purely opt-in
test for pstore.))

Christian
