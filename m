Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E6620872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCROnk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfCROnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:43:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5385730821EC;
        Mon, 18 Mar 2019 14:43:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-17.rdu2.redhat.com [10.10.120.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB0D16B479;
        Mon, 18 Mar 2019 14:43:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     dhowells@redhat.com, Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <srivasta@debian.org>,
        torvalds@linux-foundation.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Commit seems to prevent use of GNUmakefile wrappers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23499.1552920217.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 18 Mar 2019 14:43:37 +0000
Message-ID: <23500.1552920217@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 14:43:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mashiro,

	commit 2b50f7ab63685cd247e32ad321f7338ed130d3d5
	Author: Masahiro Yamada <yamada.masahiro@socionext.com>
	kbuild: add workaround for Debian make-kpkg

seems to prevent the use of GNUmakefile wrappers to set the ARCH and
CROSS_COMPILE make variables.  With this commit, I now see:

	make: Entering directory '/data/fs/linux-fs'
	Makefile:39: Do not include top Makefile of Linux Kernel
	***
	*** Configuration file ".config" not found!
	***
	*** Please run some configurator (e.g. "make oldconfig" or
	*** "make menuconfig" or "make xconfig").
	***
	Makefile:605: include/config/auto.conf: No such file or directory
	make: *** No rule to make target '.config', needed by 'include/config/auto.conf'.  Stop.
	make: Leaving directory '/data/fs/linux-fs'

Do you have a suggestion as to how to work around this?  Here's a sample
GNUmakefile content:

	CROSS_COMPILE	:= x86_64-linux-gnu-
	ARCH		:= x86_64
	MFLAGS		+= CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH)
	export CROSS_COMPILE
	export ARCH
	include Makefile

David
