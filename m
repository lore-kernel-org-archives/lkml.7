Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEEC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564FC21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576570015;
	bh=2HEttcf2FK3isDhkwY7QsOLIh5N7UrvLjCETf/Z/wY8=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=pQXkJsOu584ynWnYYU2Kf363Cz6Sg0WrAzq3X2A/vr0yWXyYKKEaV9ICEGden5rP6
	 l04BE/q24Q+R1HLET2Xru6OtsAGAU9+34WyWm5JAgMqZ4N/N11d2s556k5wNLSdOYy
	 EYqT751DNgbvtwQLyfL7dZADIZgpYpR12y7iiVwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLQIGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfLQIGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:06:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B672B2082E;
        Tue, 17 Dec 2019 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576570013;
        bh=2HEttcf2FK3isDhkwY7QsOLIh5N7UrvLjCETf/Z/wY8=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=R3if4cpVHuRrFNYaLbiz7sGH/bwdNjle6N9etawjq8zT/vIHNtiMnGnWRmP/nqpmZ
         aRNHn3kW5SpogEpAdtXeB4dmFbMkmmERy1vwIR9Mi8+rkAX87BU7LOSYhnngmTsAtP
         KFsM1UkQlHp7uPa4XyWa9aecC4Lx/tF89egvPAwE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216220555.245089-7-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-7-brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org,
        knut.omang@oracle.com, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        akpm@linux-foundation.org, alan.maguire@oracle.com,
        anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        davidgow@google.com, jdike@addtoit.com, keescook@chromium.org,
        richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org,
        yzaikin@google.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 6/6] kunit: Add 'kunit_shutdown' option
User-Agent: alot/0.8.1
Date:   Tue, 17 Dec 2019 00:06:53 -0800
Message-Id: <20191217080653.B672B2082E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-12-16 14:05:55)
> From: David Gow <davidgow@google.com>
>=20
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  lib/kunit/executor.c                | 18 ++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  3 files changed, 20 insertions(+), 2 deletions(-)

Can you document it in Documentation/admin-guide/kernel-parameters.txt ?

