Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F2CA9EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F10A20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbfKEIGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:06:02 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43749 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbfKEIGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:06:01 -0500
Received: from gandi.net (laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr [90.63.246.187])
        (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3CD66240008;
        Tue,  5 Nov 2019 08:05:54 +0000 (UTC)
Date:   Tue, 5 Nov 2019 09:05:54 +0100
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, clipos@ssi.gouv.fr
Subject: Re: Double free of struct sk_buff reported by
 SLAB_CONSISTENCY_CHECKS with init_on_free
Message-ID: <20191105080554.GA1006@gandi.net>
References: <20191104170303.GA50361@gandi.net>
 <719eebd3-259d-8beb-025a-f2d17c632711@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <719eebd3-259d-8beb-025a-f2d17c632711@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 09:33:18AM -0800, Eric Dumazet wrote:
> 
> 
> On 11/4/19 9:03 AM, Thibaut Sautereau wrote:
> > 
> > We first encountered this issue under huge network traffic (system image
> > download), and I was able to reproduce by simply sending a big packet
> > with `ping -s 65507 <ip>`, which crashes the kernel every single time.
> > 
> 
> Since you have a repro, could you start a bisection ?

From my previous email:

	"Bisection points to the following commit: 1b7e816fc80e ("mm: slub:
	Fix slab walking for init_on_free"), and indeed the BUG is not
	triggered when init_on_free is disabled."

Or are you meaning something else?

-- 
Thibaut Sautereau
CLIP OS developer
