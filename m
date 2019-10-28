Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E9820659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfJ1GYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:24:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:39005 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfJ1GYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:24:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 23:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="198554077"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2019 23:24:12 -0700
Date:   Mon, 28 Oct 2019 14:23:58 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michel Lespinasse <walken@google.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 1/2] lib/rbtree: set successor's parent unconditionally
Message-ID: <20191028062358.GA13412@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191028021442.5450-1-richardw.yang@linux.intel.com>
 <CANN689FNPD1U+gGaO5PmCuMULvkzOffOAPuB8fmyhVLHSqM7Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689FNPD1U+gGaO5PmCuMULvkzOffOAPuB8fmyhVLHSqM7Vw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 09:29:43PM -0700, Michel Lespinasse wrote:
>Code looks fine, for both commits in this series. Please make sure to
>double check that lib/rbtree_test does not show any performance
>regressions, but assuming they don't, looks great !
>

Thanks :-)

>Reviewed-By: Michel Lespinasse <walken@google.com>
>
>On Sun, Oct 27, 2019 at 7:15 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> Both in Case 2 and 3, we exchange n and s. This mean no matter whether
>> child2 is NULL or not, successor's parent should be assigned to node's.
>>
>> This patch takes this step out to make it explicit and reduce the
>> ambiguity.
>>
>> Besides, this step reduces some symbol size like rb_erase().
>>
>>    KERN_CONFIG       upstream       patched
>>    OPT_FOR_PERF      877            870
>>    OPT_FOR_SIZE      635            621
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  include/linux/rbtree_augmented.h | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
>> index fdd421b8d9ae..99c42e1a74b8 100644
>> --- a/include/linux/rbtree_augmented.h
>> +++ b/include/linux/rbtree_augmented.h
>> @@ -283,14 +283,13 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
>>                 __rb_change_child(node, successor, tmp, root);
>>
>>                 if (child2) {
>> -                       successor->__rb_parent_color = pc;
>>                         rb_set_parent_color(child2, parent, RB_BLACK);
>>                         rebalance = NULL;
>>                 } else {
>>                         unsigned long pc2 = successor->__rb_parent_color;
>> -                       successor->__rb_parent_color = pc;
>>                         rebalance = __rb_is_black(pc2) ? parent : NULL;
>>                 }
>> +               successor->__rb_parent_color = pc;
>>                 tmp = successor;
>>         }
>>
>> --
>> 2.17.1
>>
>
>
>-- 
>Michel "Walken" Lespinasse
>A program is never fully debugged until the last user dies.

-- 
Wei Yang
Help you, Help me
