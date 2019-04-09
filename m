Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274AAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588E2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDITRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:17:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfDITRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:17:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51F543003B36;
        Tue,  9 Apr 2019 19:17:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 522945C666;
        Tue,  9 Apr 2019 19:17:23 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v6 0/7] add support for audit container identifier
Date:   Tue,  9 Apr 2019 15:16:51 -0400
Message-Id: <1554837418-25278-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Apr 2019 19:17:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for audit kernel container identifiers to userspace tools.

The first and second add new record types.  The third adds filter
support.  The fourth and 5th start to add search support.

The 6th is to read the calling process' audit container identifier from
the /proc filesystem matching the kernel /proc read patch.

The last is to learn the audit container identifier of the process that
signals the audit daemon.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-kernel/issues/91
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID

Changelog:
v6
- auditd signaller tracking was moved to a new AUDIT_SIGNAL_INFO2
  request and record
- swap CONTAINER_OP contid/old-contid to ease parsing
- add to auparse

v5
- updated aux record from AUDIT_CONTAINER to AUDIT_CONTAINER_ID
- add AUDIT_CONTAINER_ID to normalization
- rebase on AUDIT_ANOM_LINK and AUDIT_MAC_CALIPSO_ADD

v4
- change from AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP
- change from AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER to
  AUDIT_FEATURE_BITMAP_CONTAINERID
- change from event_container_id to event_contid internally
- change from container_id to contid and event_container_id to
  event_contid internally
- change command line option from --container-id to --contid

v3
- change from AUDIT_CONTAINER to AUDIT_CONTAINER_ID
- change from AUDIT_CONTAINER_INFO to AUDIT_CONTAINER
- change from AUDIT_CONTAINERID to AUDIT_CONTID
- update github issue refs
- add audit_get_containerid
- change event_container_id default value
- add --containerid to ausearch options help text
- update ausearch parser and error codes

v2
- rebase on UINT_MAX patch
- add patches for AUDIT_CONTAINER, AUDIT_CONTAINER_INFO, ausearch,
  normalization

Richard Guy Briggs (7):
  AUDIT_CONTAINER_OP message type basic support
  AUDIT_CONTAINER_ID message type basic support
  auditctl: add support for AUDIT_CONTID filter
  add ausearch containerid support
  start normalization containerid support
  libaudit: add support to get the task audit container identifier
  add support for audit_signal_info2

 auparse/auditd-config.c          |   1 +
 auparse/auparse-defs.h           |   3 +-
 auparse/interpret.c              |  10 ++
 auparse/normalize_record_map.h   |   2 +
 auparse/typetab.h                |   2 +
 bindings/python/auparse_python.c |   1 +
 docs/Makefile.am                 |   2 +-
 docs/audit_get_containerid.3     |  25 +++++
 docs/audit_request_signal_info.3 |   3 +-
 docs/auditctl.8                  |   3 +
 lib/fieldtab.h                   |   1 +
 lib/libaudit.c                   | 118 ++++++++++++++++++++++-
 lib/libaudit.h                   |  31 ++++++
 lib/msg_typetab.h                |   3 +
 lib/netlink.c                    |   5 +
 src/auditctl-listing.c           |  21 +++++
 src/auditd-config.c              |   1 +
 src/auditd-config.h              |   1 +
 src/auditd-event.c               |  23 +++--
 src/auditd-reconfig.c            |  32 ++++---
 src/auditd.c                     |  33 +++----
 src/aureport-options.c           |   1 +
 src/ausearch-llist.c             |   2 +
 src/ausearch-llist.h             |   1 +
 src/ausearch-match.c             |   3 +
 src/ausearch-options.c           |  47 +++++++++-
 src/ausearch-options.h           |   1 +
 src/ausearch-parse.c             | 197 +++++++++++++++++++++++++++++++++++++++
 28 files changed, 530 insertions(+), 43 deletions(-)
 create mode 100644 docs/audit_get_containerid.3

-- 
1.8.3.1

