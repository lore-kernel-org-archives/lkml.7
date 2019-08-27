Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B43206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfH0NKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:10:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfH0NK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:10:29 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3DA6C0578F8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:10:28 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id h3so11775929pgc.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WB5qdqTIX9xVQw8FeHTpQkMeJp+LDnsJufUnItqkzHg=;
        b=W9kefueFKhnok17yr2PuRt3QxrY3mpTN+CDy1C1resBwq43jLgjrp6hR6DqbNzhD6A
         +x32AiMurrLs8Nz/Kk1Z1FzqE8SK1e3v6LfMyYuWHsbFLk2pPujuFYHUI+BWjmO5YcEB
         f6iVob1Q+dRY3Av+T/tQAYRIzVdwAPv2gqc6IAvLCbsN1LHSwr7hJO4j5lgZhPsDo0Vi
         GD2lrhQIBf7xmGk0ItClWHJvtvfGQaytJM3RoLvbPSmA8y43MZMtvGRau/3t6zNPU5DG
         Czm+M2eSg+zsCJdIA2+7A6dD3KazkaFNn1CpwQ9syF5OzGotuGDKfZ0UU2PzoFCy9yUl
         SQ6Q==
X-Gm-Message-State: APjAAAUSzwawFBpvvG7ghxuM/ZG9dgjbrm2mErp4VSucTdL44CvwHizW
        aYqO3wZlmEHxE4nTCKO0gaO7/2WbnmxTL1jOQwyBlkl9Ujcr26zTU2wNQZZI0ENQ7QSr2Sj3z+s
        id02DUfinqdzFuLoDgwuVa8uN
X-Received: by 2002:a62:82cb:: with SMTP id w194mr25027632pfd.181.1566911428158;
        Tue, 27 Aug 2019 06:10:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyT2Tx2jarPm3ooBXfwx3j891SdrFGJX1PrAnh/JG2qbesp+yVlka5LV5rjOpYbvkIW1i/ogw==
X-Received: by 2002:a62:82cb:: with SMTP id w194mr25027592pfd.181.1566911427881;
        Tue, 27 Aug 2019 06:10:27 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o67sm24393050pfb.39.2019.08.27.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 06:10:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>, peterx@redhat.com
Subject: [PATCH 0/4] KVM: selftests: Introduce VM_MODE_PXXV48_4K
Date:   Tue, 27 Aug 2019 21:10:11 +0800
Message-Id: <20190827131015.21691-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The work is based on Thomas's s390 port for dirty_log_test.

This series originates from "[PATCH] KVM: selftests: Detect max PA
width from cpuid" [1] and one of Drew's comments - instead of keeping
the hackish line to overwrite guest_pa_bits all the time, this series
introduced the new mode VM_MODE_PXXV48_4K for x86_64 platform.

The major issue is that even all the x86_64 kvm selftests are
currently using the guest mode VM_MODE_P52V48_4K, many x86_64 hosts
are not using 52 bits PA (and in most cases, far less).  If with luck
we could be having 48 bits hosts, but it's more adhoc (I've observed 3
x86_64 systems, they are having different PA width of 36, 39, 48).  I
am not sure whether this is happening to the other archs as well, but
it probably makes sense to bring the x86_64 tests to the real world on
always using the correct PA bits.

A side effect of this series is that it will also fix the crash we've
encountered on Xeon E3-1220 as mentioned [1] due to the
differenciation of PA width.

With [1], we've observed AMD host issues when with NPT=off.  However a
funny fact is that after I reworked into this series, the tests can
instead pass on both NPT=on/off.  It could be that the series changes
vm->pa_bits or other fields so something was affected.  I didn't dig
more on that though, considering we should not lose anything.

Any kind of smoke test would be greatly welcomed (especially on s390
or ARM).  Same to comments.  Thanks,

[1] https://lkml.org/lkml/2019/8/26/141

Peter Xu (4):
  KVM: selftests: Move vm type into _vm_create() internally
  KVM: selftests: Create VM earlier for dirty log test
  KVM: selftests: Introduce VM_MODE_PXXV48_4K
  KVM: selftests: Remove duplicate guest mode handling

 tools/testing/selftests/kvm/dirty_log_test.c  | 78 +++++--------------
 .../testing/selftests/kvm/include/kvm_util.h  | 17 +++-
 .../selftests/kvm/lib/aarch64/processor.c     |  3 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 77 ++++++++++++++----
 .../selftests/kvm/lib/x86_64/processor.c      |  8 +-
 5 files changed, 107 insertions(+), 76 deletions(-)

-- 
2.21.0

