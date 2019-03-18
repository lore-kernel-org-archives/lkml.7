Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC25C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A11204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfCRJpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:45:11 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:36818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727358AbfCRJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:45:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A8E10180A68B8;
        Mon, 18 Mar 2019 09:45:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: swing88_2c9538ef6284e
X-Filterd-Recvd-Size: 1753
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Mar 2019 09:45:06 +0000 (UTC)
Message-ID: <494746a793619dd9b43fb152de811a6e7de77cce.camel@perches.com>
Subject: Re: [PATCH v2 01/19] locking/lockdep: Change all print_*() return
 type to void
From:   Joe Perches <joe@perches.com>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 02:45:05 -0700
In-Reply-To: <20190318085733.3143-2-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-2-duyuyang@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +0800, Yuyang Du wrote:
> Since none of the print_*() function's return value is necessary, change
> their return type to void. No functional change.
> 
> In cases where an invariable return value is used, this change slightly
> improves readability, i.e.:
[]
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
[]
> @@ -1430,23 +1430,20 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
[]
> -static void
> -print_circular_lock_scenario(struct held_lock *src,
> -			     struct held_lock *tgt,
> -			     struct lock_list *prt)
> +static void print_circular_lock_scenario(struct held_lock *src,
> +					 struct held_lock *tgt,
> +					 struct lock_list *prt)

trivia:

This style change seems superfluous as many
other existing functions use the previous style.


