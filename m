Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC997C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA1720862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558503178;
	bh=ZKf4W2ZEdXHb5KQrZRNEOQPVKBOxuz+STTCwxY35FS4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ggO+knHsyJJX07qnTVkubfFv7vIecMDgJc+akqmT/W3xg+MsD5euuM5d77uNbnBxL
	 lcB4PmBgwDbNVFBQ/qV8H/Gvi/bD2OU7rNTp0twmBRTNl0/kFuw5NRjjb6bV39HzKQ
	 X9SKeidf/RCO+sEvb2t4VXZDH5Gr0VBNzUCZl2+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEVFc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:32:57 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33701 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVFc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:32:57 -0400
Received: by mail-pg1-f169.google.com with SMTP id h17so725042pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SzC8YCqKav54n44qt+Nuhm0unEctWwA+2ltwG2+6Tzs=;
        b=d5qYybu8wm5ze3VnAg9+PoodBXliakw6OLVvZKUaMs8A4yTCAwOj6aSAxktziYt5Rf
         Le1+tmokqMLbX4m9x3WrMCUWMUjdHcubFLSBUaOa4cj9l7lpgRkO/Ku9ziLNKCAm4cUg
         cSS1bV2UWFzMbpFwK+Cw8mIwNZoDi8mlXRRCNzryL9kMg4hxwdbESRH1TMAWrQaLOSW4
         2HB6VXL06UEGde+6qOx6a+p3SVhXEop8UXzY7AutAV5p41cF35pAK7bq6riQITMi3AHW
         4WrWqYBvxIr3xX3GUvvOU3rWEzu5xhzCdAX2bFYS9z/cL/lZtuAyp/rniqylkCGcfJgD
         atuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SzC8YCqKav54n44qt+Nuhm0unEctWwA+2ltwG2+6Tzs=;
        b=C5lWQInNuJ9nuCQQdU0HS9fV5DG8S6YluN+gtX8naEv9gDkqA+gRcWFqIbEpe+QrVL
         r+iKW5YBteEgAPAjTGxjXYxYWqmXzCLS04jaIY6golKECdg2neZr709GDTRkjUG82Lr0
         YQ9JHREDgVS8XnkAeBE+Yeyu0+u48BoLsRGtUH8zGpRsO4p6sAM2MzEhZp0TkpN+C9L/
         AUcLf5BQcskNZi5AaLFOiLDqZuOYx+eivUM8QA2jgK3nlVg7ik22nsGtpajYYjSIuz6R
         5O6CGfT9bMvNyAZ7mNZVBIUozFU9YDqhyevNEdvFifYt0ciDO/FW5gahN9Zy+7aJ4YVl
         PkVQ==
X-Gm-Message-State: APjAAAWJtKPhCWEXra0xSFg0BB7V93Hh3mDiu5oj6ipGFXHAoATFMS1c
        fKeRv6dHsO6SvX5ScJLEWow=
X-Google-Smtp-Source: APXvYqz5afBI1AsBykKbJ+WEeQGJ1WXwWaTj5mZco0gCye5CGzAg4OipEWUnok2O6g8kamD20w97FA==
X-Received: by 2002:a62:3381:: with SMTP id z123mr95031766pfz.42.1558503176731;
        Tue, 21 May 2019 22:32:56 -0700 (PDT)
Received: from namhyung.seo.corp.google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id p7sm25027927pgb.92.2019.05.21.22.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 22:32:55 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf tools: Assorted fixes and cleanups for namespace events
Date:   Wed, 22 May 2019 14:32:47 +0900
Message-Id: <20190522053250.207156-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These are some missing pieces that I found during the code-reading.


Thanks,
Namhyung


Namhyung Kim (3):
  perf tools: Protect reading thread's namespace
  perf tools: Add missing swap ops for namespace events
  perf top: Enable --namespaces option

 tools/perf/Documentation/perf-top.txt |  5 +++++
 tools/perf/builtin-top.c              |  5 +++++
 tools/perf/util/session.c             | 21 +++++++++++++++++++++
 tools/perf/util/thread.c              | 15 +++++++++++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

