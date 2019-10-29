Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D15CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B5F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnUlLPeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390389AbfJ2Qck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:32:40 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:54648 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390258AbfJ2Qcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:32:39 -0400
Received: by mail-wr1-f73.google.com with SMTP id e14so8748888wrm.21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aFBVvPMXMdVoNWS+arga+zyutc52PrhwrmcehtICP7Y=;
        b=dnUlLPeHrSuhFF3+r3nexRhXSUgG2QFJmbgnM7MsHtu9FFwvUjdpifIlzbNDwRGkd/
         Rugpk2suP1+NWI0NcnbXkosWcp5TC1CcRvDazP+lW6hm5NaO4SXfRFuKQfst1xaVJ735
         loWFY3SBTLlZeW5p5a4BNCH8n5LF1tQy9M5Dcw9+Hx9HDhgklnBWRMOaVr3t+JbGQwPk
         o6f2umBa8YgNSH/0EA9o69e8rdGo1yiXatKJ1mHoKWzbMUsqFfKYyPCdlgB1rnZCCvbE
         ikFEJ8JrBVmn8KZDM/0CUXuDXrNd2ZFJCWCzeVgBfFhqtnbvvxAlQICeYgavC606yNrC
         8ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aFBVvPMXMdVoNWS+arga+zyutc52PrhwrmcehtICP7Y=;
        b=evQPV8U2xo0qi2g8wT4kJpZnLANpeXARcvxJT55kBOkK2phOvk4fssTLhNAiFmCduU
         SHUXFCcdW2ZDrvcLxcsgs1ykkYZ68I1hEnOXZC4VQxqaqa1+9WCquLQZYJOiKrfhP2yH
         +7Zcg8rJwahaqAXxVG89DDpaAzZNlIKL0ac9kRMeq+BY2I1/P6RwzU3Duw35S16SIYwY
         H7INnESBxu1tw7sDxr8YwfF/7LV7eLnN+lN776Xpq8Ez46eJe2H8FqmkgO0SkhBvhbwX
         XnzjX4TF70IaLIW5kppjQ4EEzw9s+wK73Nm/1pye7aP76UTaOnHjT/LEq08U43qjdFvu
         9rVg==
X-Gm-Message-State: APjAAAUptn3hU8Ljm/TsB+HjxYrJ1009eF2talChYEt454tHKvcmRyau
        v75nQT3G/rvjK1iO504L2sJVJvZ9nfo4katl
X-Google-Smtp-Source: APXvYqyQYFo/SVqLudHuBq0akKPCDJONWrXAYKTaEfxtfHzCYvYIvxkO/0zufmfXYgX8y9D4iHgx4ShS3grBopTf
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr20520344wrx.30.1572366756966;
 Tue, 29 Oct 2019 09:32:36 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:32:26 +0100
Message-Id: <cover.1572366574.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 0/3] kcov: collect coverage from usb and vhost
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends kcov to allow collecting coverage from backgound
kernel threads. This extension requires custom annotations for each of the
places where coverage collection is desired. This patchset implements this
for hub events in the USB subsystem and for vhost workers. See the first
patch description for details about the kcov extension. The other two
patches apply this kcov extension to USB and vhost.

Examples of other subsystems that might potentially benefit from this when
custom annotations are added (the list is based on process_one_work()
callers for bugs recently reported by syzbot):
1. fs: writeback wb_workfn() worker,
2. net: addrconf_dad_work()/addrconf_verify_work() workers,
3. net: neigh_periodic_work() worker,
4. net/p9: p9_write_work()/p9_read_work() workers,
5. block: blk_mq_run_work_fn() worker.

These patches have been used to enable coverage-guided USB fuzzing with
syzkaller for the last few years, see the details here:

https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/1524

Changes v2 -> v3:
- Removed using u64 division as arm can't do that.
- Added EXPORT_SYMBOL() for kcov_common_handle(), kcov_remote_start() and
  kcov_remote_stop().
- Added usage comments for kcov_remote_start(), kcov_remote_stop() and
  kcov_common_handle().
- Expanded a comment in kcov_task_exit() to better explain WARN_ON()
  condition.
- Reduced KCOV_REMOTE_MAX_HANDLES to 0x100 to avoid allowing too many
  GFP_ATOMIC allocations.

Changes v1 -> v2:
- Changed common_handle type back to u64 (to allow extending it in the
  future).
- Reworked kcov_remote_handle() helpers.
- Fixed vhost annotations when CONFIG_KCOV is not enabled.
- Use kcov_disable() instead of kcov_remote_reset() when
  KCOV_REMOTE_ENABLE fails.

Changes RFC v1 -> v1:
- Remove unnecessary #ifdef's from drivers/vhost/vhost.c.
- Reset t->kcov when area allocation fails in kcov_remote_start().
- Use struct_size to calculate array size in kcov_ioctl().
- Add a limit on area_size in kcov_remote_arg.
- Added kcov_disable() helper.
- Changed encoding of kcov remote handle ids, see the documentation.
- Added a comment reference for kcov_sequence task_struct field.
- Change common_handle type to u32.
- Add checks for handle validity into kcov_ioctl_locked() and
    kcov_remote_start().
- Updated documentation to reflect the changes.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Andrey Konovalov (3):
  kcov: remote coverage support
  usb, kcov: collect coverage from hub_event
  vhost, kcov: collect coverage from vhost_worker

 Documentation/dev-tools/kcov.rst | 129 ++++++++
 drivers/usb/core/hub.c           |   5 +
 drivers/vhost/vhost.c            |   6 +
 drivers/vhost/vhost.h            |   1 +
 include/linux/kcov.h             |  23 ++
 include/linux/sched.h            |   8 +
 include/uapi/linux/kcov.h        |  28 ++
 kernel/kcov.c                    | 547 +++++++++++++++++++++++++++++--
 8 files changed, 712 insertions(+), 35 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

