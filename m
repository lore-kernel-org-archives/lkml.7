Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59326CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEAA21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571988390;
	bh=kvo1v9a27oDdMcQmRgQs0tPNr5ubyePVrnMAdv049pY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BCic/a7y7oR+MjRuNY+pxW3OfgKZH7YINcp6DbPTrT4ce4FKGKcc1pXV/hzmDroTY
	 YfaajCx3uTcJH9R71U0sPsiINRZUn0Txo2l5aHNlWyUhlo61OPfvu4leCiSZPC3lrW
	 7HTWxtLPKVBCCLtnamYh4oUnwmgmF5/XuAuN9o7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436490AbfJYH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:26:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35795 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732149AbfJYH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:26:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so1074936wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVXnrlurDnNuyFHkl/Vg0+Qizz8MAljfZrQeUc5+AOA=;
        b=nG0iaYuVKj7PaOkTEI40anyaePU9lilma/CxZk4+caMoYXB974hmwMf6kywISEAYim
         aglLKlG+/41xvp/3b/cXhcjlrsxkn6Kg9+q1nTXT0eSM/aMy9ax7fBfnNd/NKoirEWTX
         ERxjkM0DsMAE3wp+iklLlTwkFJxeZ0hJKNRON2XvtlkmVXWhECT3Qxhe1r5wc5wBBf8y
         rYWTCPTC3q49W8R3HqNsFOeA0PulFfk+5Q9Jlj8sE8kjqpUduSl/C6uYgKBu6+zqk0Tk
         ujimTTsdVCHVV7wzXHiR8bOfwYmLV8aw4XxKS9fC00L8zNFuu9vNtk2KDr2DcuPeEk7T
         Bd7g==
X-Gm-Message-State: APjAAAWAwAhI99NMTAAsq8mvA+x7589Zgjsh8I+AlhDMC5tpfVShJZp0
        tYLt/ZQDoKhzSczMcNq3o3RnJE9c
X-Google-Smtp-Source: APXvYqz2Pu3ZENVB2RnwQ/z0ER/06Wuo1LBrrPn0Kr1n7nZK4fVkudnDjvJaukKp+YpQdXSxkpNtOA==
X-Received: by 2002:a05:6000:11c4:: with SMTP id i4mr1415503wrx.277.1571988386382;
        Fri, 25 Oct 2019 00:26:26 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x21sm1482446wmj.42.2019.10.25.00.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:26:24 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mm: reduce /proc/pagetypeinfo ovehead
Date:   Fri, 25 Oct 2019 09:26:08 +0200
Message-Id: <20191025072610.18526-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Waiman Long has reported [1] that reading /proc/pagetypeinfo can
severely interfere with the system and it might lead even to hard lockup
detector firing up on a very large machines. Nevertheless small machines
are not completely fine either because the operation requires to take
the zone->lock IRQ safe spinlock and thus to interfere with both the IRQ
delivery and the page allocator. The file is world readable which makes
this kinda bad.

The immediate danger is addressed by making the file root readable only.
This is a debugging aid so general audience shouldn't require it for a
general operation. This is done in the first patch.

The potentially excessive time spent for free_list iteration is handled
by capping the iteration loop. This should be fine for existing usecases
because low numbers are usually of the primary interest. This is
implemented in patch 2.

I am reposting these two patches with dropped RFC (previously posted
[2]) and asking for inclusion. I have also dropped Mel's Ack from the
second patch because there were quite some changes since he reviewed. 

[1] http://lkml.kernel.org/r/20191022162156.17316-1-longman@redhat.com
[2] http://lkml.kernel.org/r/20191023102737.32274-1-mhocko@kernel.org

