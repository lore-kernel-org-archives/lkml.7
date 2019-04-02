Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DA9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6B1206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfDBQ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:57:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:34929 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbfDBQ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:57:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 09:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="147420263"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2019 09:57:21 -0700
Date:   Tue, 2 Apr 2019 09:57:21 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch 12/14] x86/cpu: Prepare TSS.IST setup for guard pages
Message-ID: <20190402165720.GD29004@linux.intel.com>
References: <20190331214020.836098943@linutronix.de>
 <20190331215135.858900919@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331215135.858900919@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:40:32PM +0200, Thomas Gleixner wrote:
> Convert the TSS.IST setup code to use the cpu entry area information
> directly instead of assuming a linear mapping of the IST stacks.
> 
> The store to orig_ist[] is not longer required as there are no users
                             ^^^
                             no
> anymore.
> 
> This is the last preparatory step for IST guard pages.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
