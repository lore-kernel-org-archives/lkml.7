Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E96C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28088206F4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLHN5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:57:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60210 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfLHNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 08:54:43 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1C-0007eA-TY; Sun, 08 Dec 2019 13:54:38 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1B-0002Mz-HH; Sun, 08 Dec 2019 13:54:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Johannes Berg" <johannes.berg@intel.com>,
        "Denis Kenzior" <denkenz@gmail.com>
Date:   Sun, 08 Dec 2019 13:53:16 +0000
Message-ID: <lsq.1575813165.169588071@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 32/72] cfg80211: Purge frame registrations on iftype
 change
In-Reply-To: <lsq.1575813164.154362148@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.79-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Kenzior <denkenz@gmail.com>

commit c1d3ad84eae35414b6b334790048406bd6301b12 upstream.

Currently frame registrations are not purged, even when changing the
interface type.  This can lead to potentially weird situations where
frames possibly not allowed on a given interface type remain registered
due to the type switching happening after registration.

The kernel currently relies on userspace apps to actually purge the
registrations themselves, this is not something that the kernel should
rely on.

Add a call to cfg80211_mlme_purge_registrations() to forcefully remove
any registrations left over prior to switching the iftype.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Link: https://lore.kernel.org/r/20190828211110.15005-1-denkenz@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/util.c | 1 +
 1 file changed, 1 insertion(+)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -926,6 +926,7 @@ int cfg80211_change_iface(struct cfg8021
 		}
 
 		cfg80211_process_rdev_events(rdev);
+		cfg80211_mlme_purge_registrations(dev->ieee80211_ptr);
 	}
 
 	err = rdev_change_virtual_intf(rdev, dev, ntype, flags, params);

