Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE155C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02420659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfGOTjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:39:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:61122 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfGOTji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:39:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 12:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,494,1557212400"; 
   d="scan'208";a="169703518"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2019 12:39:38 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2F885301AE9; Mon, 15 Jul 2019 12:39:38 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:39:38 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andrew Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
Message-ID: <20190715193938.GG32439@tassilo.jf.intel.com>
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <8736j7gsza.fsf@linux.intel.com>
 <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, we don't know where the PAT invocation comes from and whether they
> are safe to omit flushing the cache. The module load code would be one
> obvious candidate.

Module load just changes the writable/executable status, right? That shouldn't
need to flush in any case because it doesn't change the caching attributes.

-Andi
