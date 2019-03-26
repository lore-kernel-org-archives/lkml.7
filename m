Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C7EC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2626B20700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553633824;
	bh=kUDZ2zUOC1VjYDB54pnTJgDj1F27tKtH5SJ0qn/GMnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ex08LYJRMsQQEjXycuHUHchzFR3MVfL/bq59MQx03gzPc3ZeSnnbr622rx6MtqGzN
	 ZF96bWM0U6jE4vsXcLqCNZ+ye8fZEXOMaQs0TLEJVaI5PGBWD53NfV3rdAjJZjDst+
	 PbErJ4MFQXm0JbUOewCbX4y0PNfZL+9qnNDbrG9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfCZU5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731994AbfCZU5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:57:03 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBC12146F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553633822;
        bh=kUDZ2zUOC1VjYDB54pnTJgDj1F27tKtH5SJ0qn/GMnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2EdBUk8D0jHd3PSSLdJs+9AMkbAwSohmSx7F/2BXsS97m3kdqI3KlZ79ifK4r1Zqy
         QHOEetiWWZi4hGeSuMZFG2XoR5e4HOkd7ms7m2lN1N1VBnR9rBxNQ7Aoa/1koyepAg
         kndCgahWO6SWucZtREJoBNhwFsRz687u4mK2Kb6U=
Received: by mail-wr1-f54.google.com with SMTP id o1so15990140wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:57:01 -0700 (PDT)
X-Gm-Message-State: APjAAAW+CRS7eJieqxPY0UCpuoEBG9KCwnLBA5OspJYRvK0AG0IyF3cS
        dpCiIaoVi20s1cFnGk0DZr9gbk0jY0OLMOhZ9TohTQ==
X-Google-Smtp-Source: APXvYqzxoUo1vfBTqorVoX066CxosSL4WuvKRvUOgFr27IdD3TH+1Mg6eSU/qXaRxwUkJ4m2bqWX6H29aioPvAbHV7U=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr20043765wrq.176.1553633820586;
 Tue, 26 Mar 2019 13:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com> <20190326182742.16950-12-matthewgarrett@google.com>
In-Reply-To: <20190326182742.16950-12-matthewgarrett@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 13:56:49 -0700
X-Gmail-Original-Message-ID: <CALCETrVjhHbJ+41fY9ra7YBm42ingOZ0_XjY=xAxLUU8n0U=9Q@mail.gmail.com>
Message-ID: <CALCETrVjhHbJ+41fY9ra7YBm42ingOZ0_XjY=xAxLUU8n0U=9Q@mail.gmail.com>
Subject: Re: [PATCH V31 11/25] x86: Lock down IO port access when the kernel
 is locked down
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: Matthew Garrett <mjg59@srcf.ucam.org>
>
> IO port access would permit users to gain access to PCI configuration
> registers, which in turn (on a lot of hardware) give access to MMIO
> register space. This would potentially permit root to trigger arbitrary
> DMA, so lock it down by default.
>
> This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
> KDDISABIO console ioctls.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
