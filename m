Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACC9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77C24683
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPLGNJ8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLRPbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:31:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25678 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726955AbfLRPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576683081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Nu4re5DJtt7kCRpoMSpCYfrOekqJ3V3x1aYPZ4h9ezM=;
        b=GPLGNJ8VqxrRQehKDyFJHAAeDFExArbuYh7eLBdfn8/pvoI85/+cW/wmG5xI3anu368JO4
        5FUE78i/sZRkYm7JSr0e2Zo2VZ566AG0A/MBh9EOyHUx+CFb1zCC66t5LRAgzcYFtlTHxd
        mmfpNAI8pwBY5f+O5/9IvmKThGZhRL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-wtG94tcuOXOJO92wC1j41w-1; Wed, 18 Dec 2019 10:31:15 -0500
X-MC-Unique: wtG94tcuOXOJO92wC1j41w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76893109E572;
        Wed, 18 Dec 2019 15:31:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id EAFE168894;
        Wed, 18 Dec 2019 15:31:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 18 Dec 2019 16:31:09 +0100 (CET)
Date:   Wed, 18 Dec 2019 16:31:07 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Q: does force_iret() make any sense today?
Message-ID: <20191218153107.GA3489@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not pretend I understand the arch/x86/entry/ code, but it seems that
asm does all the necessary checks and the "extra" TIF_NOTIFY_RESUME simply
has no effect except tracehook_notify_resume() will be called for no reason?

Oleg.

