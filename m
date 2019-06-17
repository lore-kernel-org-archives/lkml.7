Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D26DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE306208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QRu0V2LM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfFQTqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:46:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfFQTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:46:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJjr1O3569451
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:45:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJjr1O3569451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800754;
        bh=sVblce1QqAbRDcxijcZknjzKyriDsw4WtxG3w2XJO/M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QRu0V2LMC6ZdZnOdMludwlMIOJf/biIHOFvNYTyk6nKdpXX9uegPWKiSmMNR3D8tE
         eqpgYWDAGBpHjhnIoXOUSnWWmdZdUsLw0QpgyfnxScfxpPVU4Iuj3B6RsEVlMVRdo5
         YDXFcVKjf33o4P6CLvO8h5eJzLnf9yhnXfg4ik98+hr+dTpZr+40B3VndOLlP+Olpo
         f4XKcfIJZKnYblWeMGtPx2HdA+niJuNn/akpCYMHtEdIY9OmXIsZqTnPzIUjX7NoNg
         pD+Ya9F9XY7tC8NPQ8HgRD7UwNlhb2XLQbw+Tu9CSn6/EfuhSOFDkbvf1NMKKTezm2
         8QaLYXV2c5tyw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJjr1H3569448;
        Mon, 17 Jun 2019 12:45:53 -0700
Date:   Mon, 17 Jun 2019 12:45:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-f79a7689d99366aee9f89d785bca6c52ed6b76eb@git.kernel.org>
Cc:     yao.jin@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, jolsa@redhat.com, acme@redhat.com
Reply-To: acme@redhat.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          hpa@zytor.com, yao.jin@linux.intel.com
In-Reply-To: <20190604130017.31207-13-adrian.hunter@intel.com>
References: <20190604130017.31207-13-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Treat time ranges consistently
Git-Commit-ID: f79a7689d99366aee9f89d785bca6c52ed6b76eb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f79a7689d99366aee9f89d785bca6c52ed6b76eb
Gitweb:     https://git.kernel.org/tip/f79a7689d99366aee9f89d785bca6c52ed6b76eb
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:10 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf time-utils: Treat time ranges consistently

Currently, options allow only 1 explicit (non-percentage) time range.
In preparation for adding support for multiple explicit time ranges,
treat time ranges consistently.

Instead of treating some time ranges as inclusive and some as excluding
the end time, treat all time ranges as inclusive. This is only a 1
nanosecond change but is necessary to treat multiple explicit time
ranges in a consistent manner.

Note, there is a later patch that adds a test for time-utils.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 20663a460df3..1d67cf1216c7 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -389,13 +389,12 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 		ptime = &ptime_buf[i];
 
 		if (timestamp >= ptime->start &&
-		    ((timestamp < ptime->end && i < num - 1) ||
-		     (timestamp <= ptime->end && i == num - 1))) {
-			break;
+		    (timestamp <= ptime->end || !ptime->end)) {
+			return false;
 		}
 	}
 
-	return (i == num) ? true : false;
+	return true;
 }
 
 int perf_time__parse_for_ranges(const char *time_str,
