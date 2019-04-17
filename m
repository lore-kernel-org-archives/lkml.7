Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E734C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B592183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbfDQVPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:15:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:5952 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQVPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:15:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 14:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,363,1549958400"; 
   d="scan'208";a="162819828"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2019 14:15:49 -0700
Date:   Wed, 17 Apr 2019 14:15:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190417211549.GA17200@agluck-desk>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic>
 <20190416221852.GA10781@agluck-desk>
 <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
 <20190416232833.GA17372@agluck-desk>
 <CAM_iQpXBJ2eAz4TW_GmOWRLrkyJcO=u-8VSnmv91ZABG-21Agg@mail.gmail.com>
 <20190417015351.GA28490@agluck-desk>
 <CAM_iQpWXYTivg6tmGxB0xVSrcz8_Envb+yRh_6tBuX-DYKuL1Q@mail.gmail.com>
 <CAM_iQpVom+7oHCUh1=oWrR9NiHfDSGOWoOFV4tkdT6nnZKicmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVom+7oHCUh1=oWrR9NiHfDSGOWoOFV4tkdT6nnZKicmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 07:37:41PM -0700, Cong Wang wrote:
> On Tue, Apr 16, 2019 at 7:31 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > Yes it is, I have a stacktrace in production which clearly shows
> > del_elem.isra.1+0x34/0x40, unlike the one I triggered via fake
> > PFN's. I can show you if you want, it is on 4.14, so very unlikely
> > it is interesting to anyone here.
> 
> Correct myself:
> 
> The one triggered via fake PFN's also shows
> del_elem.constprop.1+0x39/0x40.
> 
> Sorry for the mistake, I kinda read into another crash...

Ok. Now I follow what you are saying. I'll try to rephrase
here.

1) Initial setup is that we filled the array. Set the threshold
to a low value, and then repeatedly added a new pfn (with a
value higher than any in the array).

2) First time:
We find the array is full, so delete one item. Add the new pfn
to the end (in slot MAX_ELEM-1)

3) Next time. Array is full. Delete one item (assume not the one
for our target pfn). This moved our target to slot MAX_ELEM-2.

4) Next time. Array isn't full. We get a hit on our pfn. Bump
the count. Find that it exceeded the threshold, so ask to
offline it. We delete this from the array. It is a tail
deletion so we just decrement ca->n.

5) Final time. Array isn't full. When we look for our pfn in
the array it isn't in the array[0,ca->n) range. So we ought
to return ENOKEY. But we don't. When we fall out of the
search loop:

136         while (min < max) {
137                 int tmp = (max + min) >> 1;
138
139                 this_pfn = PFN(ca->array[tmp]);
140
141                 if (this_pfn < pfn)
142                         min = tmp + 1;
143                 else if (this_pfn > pfn)
144                         max = tmp;
145                 else {
146                         min = tmp;
147                         break;
148                 }
149         }

We exit because "min" is not less than "max". We assign
"*to" with the index of the available slot.

151         if (to)
152                 *to = min;

This line is just wrong. "min" is still within the allocated
bounds of the array, but the value is "ca->n", i.e. the first
unused slot. The "garbage" value we pick up from here is what
was last assigned to the slot when it was valid. Because we have
been adding the same pfn over and over, the value we pick up is
the pfn that we "deleted" in step "4" above. But remember we
deleted it just by adjusting ca->n, not by overwriting this
entry.

154         this_pfn = PFN(ca->array[min]);


So now this test succeeds, when it should fail. We return
an index of "ca->n".
156         if (this_pfn == pfn)
157                 return min;
158
159         return -ENOKEY;

Things go downhill fast from here. We update the count for
this entry. Find it is above the threshold, so offline the
page and try to delete.

226 static void del_elem(struct ce_array *ca, int idx)
227 {
228         /* Save us a function call when deleting the last element. */

idx is equal to ca->n. So this is "if (-1)" ... so we decide
we need to memmove some entries.  The array indices "idx" and "idx+1"
are not out of bounds for the allocated size, but they aren't what we
want. The real problem is the count passed to memmove.

229         if (ca->n - (idx + 1))
230                 memmove((void *)&ca->array[idx],
231                         (void *)&ca->array[idx + 1],
232                         (ca->n - (idx + 1)) * sizeof(u64));
233
234         ca->n--;
235 }


So I'm now liking this version of the patch by Cong:


diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 2d9ec378a8bc..b7cb0b9b1346 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -204,10 +204,12 @@ static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 	if (to)
 		*to = min;
 
-	this_pfn = PFN(ca->array[min]);
+	if (min < ca->n) {
+		this_pfn = PFN(ca->array[min]);
 
-	if (this_pfn == pfn)
-		return min;
+		if (this_pfn == pfn)
+			return min;
+	}
 
 	return -ENOKEY;
 }

Reviewed-by: Tony Luck <tony.luck@intel.com>
