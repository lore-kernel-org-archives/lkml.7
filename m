Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57FF21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254921;
	bh=2CUxJUH8XRn9678sXuORd/gLYT7BCor3ALtqRz/UObY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=psHfbhO7X5jifPsqvWMQii/GR5mjPn/yr4bnkNFCoxXulEr+w/BU5rhszekUk1uWn
	 s2jREt6Bdi/YMerm867pKxYtika3dEQy5dMRheFYO7BFLRnsnb2ZFgLg1HDWeFGtzK
	 g4aaOYQ4EhvYp2zP6mrTy3BCnq5Gmd6zQaAl+GIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfCVLl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbfCVLl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:41:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3131D218B0;
        Fri, 22 Mar 2019 11:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254916;
        bh=2CUxJUH8XRn9678sXuORd/gLYT7BCor3ALtqRz/UObY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSKlNDXrFrFTp0dwnsBrx30YWX7oxKAKAlSn0w0TfnErEGMacWmvLyv9OBfP32lGo
         upukGJcnbLrpxj62Hc5jcavnzsRekSM3ncOnA4Ad7PfRvJsDgIcVovZfRrnaBVBST5
         JrUAqvqA+GZWy9KGumJgZ6XWES+g9zK7S8PDSB6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 050/118] tracing: Use strncpy instead of memcpy for string keys in hist triggers
Date:   Fri, 22 Mar 2019 12:15:22 +0100
Message-Id: <20190322111219.960075837@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Zanussi <tom.zanussi@linux.intel.com>

commit 9f0bbf3115ca9f91f43b7c74e9ac7d79f47fc6c2 upstream.

Because there may be random garbage beyond a string's null terminator,
it's not correct to copy the the complete character array for use as a
hist trigger key.  This results in multiple histogram entries for the
'same' string key.

So, in the case of a string key, use strncpy instead of memcpy to
avoid copying in the extra bytes.

Before, using the gdbus entries in the following hist trigger as an
example:

  # echo 'hist:key=comm' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist

  ...

  { comm: ImgDecoder #4                      } hitcount:        203
  { comm: gmain                              } hitcount:        213
  { comm: gmain                              } hitcount:        216
  { comm: StreamTrans #73                    } hitcount:        221
  { comm: mozStorage #3                      } hitcount:        230
  { comm: gdbus                              } hitcount:        233
  { comm: StyleThread#5                      } hitcount:        253
  { comm: gdbus                              } hitcount:        256
  { comm: gdbus                              } hitcount:        260
  { comm: StyleThread#4                      } hitcount:        271

  ...

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  51

After:

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  1

Link: http://lkml.kernel.org/r/50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 79e577cbce4c4 ("tracing: Support string type key properly")
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_hist.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -871,9 +871,10 @@ static inline void add_to_key(char *comp
 		/* ensure NULL-termination */
 		if (size > key_field->size - 1)
 			size = key_field->size - 1;
-	}
 
-	memcpy(compound_key + key_field->offset, key, size);
+		strncpy(compound_key + key_field->offset, (char *)key, size);
+	} else
+		memcpy(compound_key + key_field->offset, key, size);
 }
 
 static void event_hist_trigger(struct event_trigger_data *data, void *rec)


