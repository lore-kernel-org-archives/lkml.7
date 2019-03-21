Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DAF218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfCUN7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:59:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:34018 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCUN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:59:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 06:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="329353525"
Received: from dilu-mobl2.ccr.corp.intel.com (HELO localhost) ([10.249.254.184])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2019 06:59:40 -0700
Date:   Thu, 21 Mar 2019 15:59:39 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     grawity@gmail.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <20190321135939.GF4603@linux.intel.com>
References: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:31:34PM -0700, Tadeusz Struk wrote:
> The poll condition should only check response_length,
> because reads should only be issued if there is data to read.
> The response_read flag only prevents double writes.
> The problem was that the write set the response_read to false,
> enqued a tpm job, and returned. Then application called poll
> which checked the response_read flag and returned EPOLLIN.
> Then the application called read, but got nothing.
> After all that the async_work kicked in.
> Added also mutex_lock around the poll check to prevent
> other possible race conditions.
> 
> Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Can you send v3 with the comment and cc to stable? Then this
should be fine.

/Jarkko
