Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838CCC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640C121823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfLEK4T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:56:19 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:18248 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfLEK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:56:18 -0500
IronPort-SDR: EhnRgSnZ7ptNGwLo7p31k09YQW4Oab9ACLKU+R6bF2YmLtocmLxanO4CB2fh+Pz2/nkZfDGff0
 NxEayFeJiuLfrAl4kax19XSvGmdLjgmPI4bg4ga/b5HEzeEnAlZ9v5vjz61B8OsBd8xhIkbCNC
 2BWwlxL6aFIMO2m3rHBrUHVn5wVylZctvUn3yEdaTvzXMG4Gm3rAGCXLDobztSJE9qg4LpDblH
 UiUbJcLpylKoZdbRfvdFOFiY0jUIMZ08+0+mgan6fvuYojfyY9kGZJj9/AZ7mgGJ6SnMmLgjyw
 l7I=
X-IronPort-AV: E=Sophos;i="5.69,281,1571731200"; 
   d="scan'208";a="43734030"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 05 Dec 2019 02:56:18 -0800
IronPort-SDR: DHcOYqEYCIexs8/1AcHZUJt/AVUVRRn3LG7DYarWurKjbUc5CRciV0zPkyHhdTbPq3hE0Yd2SI
 ySjs7UHV0sg/bXJxCHgfHIKpK/D0UqabGvs5lFNoclAyAE0Vx+n+21mAD2a6/OOg+WMDqttWPe
 tkyHpXZUeTX99jm3WTAZrLVuX4CcLSZ3V+Ia3lag7ubVyS0bIeigMYORyjoGHrs+t2BPvH7cMg
 YgPjtlGtf/I4tqzxqVBdGeApBWdYwSfzFsSpuFlTyRfULfwnf9urib6udEbZz80LmWt9L424mL
 e5c=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "walken@google.com" <walken@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: AW: Crash in fair scheduler
Thread-Topic: Crash in fair scheduler
Thread-Index: AQHVqbfg64Wqju89WkedWbWijDxswKeoNgIAgAADvACAADdAgIAC7eEg
Date:   Thu, 5 Dec 2019 10:56:13 +0000
Message-ID: <ad7d2769ae3b4d8a88e4f67d5fb800cf@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1575364273836.74450@mentor.com>
 <20191203103046.GJ2827@hirez.programming.kicks-ass.net>
 <656260cf50684c11a3122aca88dde0cb@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191203140153.GP2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191203140153.GP2844@hirez.programming.kicks-ass.net>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Peter Zijlstra [mailto:peterz@infradead.org]

> 
> Exatly.
> 
> 
> I suppose one approach is to add code to both __enqueue_entity() and
> __dequeue_entity() that compares ->rb_leftmost to the result of
> rb_first(). That'd incur some overhead but it'd double check the logic.

As this is a ONCE without reproducer, i would prefer to use an approach
to exactly check for this case in the code path where it crashed.
Something like this (with pseudo-code):

simple:
....

do {
  se = pick_next_entity(..)
  if (unlikely(!se)) { /* here we check for the issue */
     write warning and some useful data to dmesg
     if (cur_rq->rb_leftmost == NULL) { /* our case */
       set cur_rq->rb_leftmost to itself as mentioned in the discussion
       se = pick_next_entity(..)       /* should now return a valid pointer */
     } else { /* another case happened, unknown */
        write warning to dmesg UNKNOWN
        panic() /* not known what to do here, would crash anyway. */
     }
  set_next_entity(se, ..)
  cfs_rq = group_cfs_rq(...)
} while (cfs_rq);

This will definitely not fix the rb_leftmost being NULL, but we can't tell
where this happened at all, so it's digging in the dark.
Maybe the data written to dmesg will help to diagnose further, if the issue
will happen again.
And, this will not affect performance much, as i have to take care of this too.

Thanks for all your suggestions.
Carsten
