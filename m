Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32140CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10F520640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAzG96Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfJUOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:21:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27390 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726289AbfJUOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571667683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXrHWhiwOCJRToyN96S6wFZkmcZIF7RksXCsxcL0ZHo=;
        b=LAzG96Pu5+GWLUmPoWbifFXIkOY7EbZn7FOmgPtZqPMZ84k6dgU7HfYGHveyxO7TaFhZcd
        ZyjYx76oij2ox6B0QGzy4OuzIDGWlCxwdDz7DtShkOQAL5alp10A4/1jbM3n7zsPO+lOpf
        apatIApCzzxtKusWaHYluqE2Xr02ihw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-QXBWfOh3NLGuZvs4eNiVCA-1; Mon, 21 Oct 2019 10:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B1C1005500;
        Mon, 21 Oct 2019 14:21:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1AB2610018FF;
        Mon, 21 Oct 2019 14:21:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 21 Oct 2019 16:21:14 +0200 (CEST)
Date:   Mon, 21 Oct 2019 16:21:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: cgroup_enable_task_cg_lists && PF_EXITING (Was: KCSAN: data-race in
 exit_signals / prepare_signal)
Message-ID: <20191021142111.GB1339@redhat.com>
References: <0000000000003b1e8005956939f1@google.com>
MIME-Version: 1.0
In-Reply-To: <0000000000003b1e8005956939f1@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QXBWfOh3NLGuZvs4eNiVCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

could you explain the usage of siglock/PF_EXITING in
cgroup_enable_task_cg_lists() ?

PF_EXITING is protected by cgroup_threadgroup_rwsem, not by
sighand->siglock.

Oleg.

