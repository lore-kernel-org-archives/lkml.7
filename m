Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E6C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C720659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzQNWrBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbfGPUcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:32:46 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36980 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPUcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:32:45 -0400
Received: by mail-vs1-f67.google.com with SMTP id v6so14881240vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81NxWyaYYLOx3U0CNAY+vem2FwAQtGrb2n7o/OCCQ6Q=;
        b=EzQNWrBC5qDZZtG/w0lKikRR/oNojiw9cBTeaFyF+wRtC0dUeoMDAVmJAyqgyBzSEe
         NnHR+bKb6u1SnmKae3PIH+umXwHZMHtFajbm/8e/0FKjLrjds+MrgdBNWGVgxTk/yr6r
         a85dbUuIp7o5N3v/8tNZHHWO3WTJG2qgU7hh2JmzThDmC4LWVEqOIQxnLnkYtDSCe2ti
         5FQhqEyqvKKdQWNiHM1ecC46U6rAWhmCVAaC9TfrC8eScLAfgKAcSwq1bSAoiEmgzGkY
         v9jXDgZ1Ero5tUf69xUGxmjRwnF44LzOVHGe3Veh7QYw4fFvqvGOrUYAfq8zFdebhPQT
         bgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81NxWyaYYLOx3U0CNAY+vem2FwAQtGrb2n7o/OCCQ6Q=;
        b=rs21K/Jkz2lLM10gfVh64VFvEuIJLWVL8EEK3VvK7VzfnpNawu5Q9FFKEt807uRht7
         2+Fyf0UK1Mmq8NtuiNz4f7GwLuxGEivZ9VtzuBLIWqE/09iDEVcwXM2PbXYi917oRx6n
         pLKmn/pdmLl7bEDPbQT+wbbISDjAYDXxcto3cC5myBrnGWuesIWMt3r1sSguoqcbiL+q
         yRBt4tCi4eQ6v5mf4yjKU4TouEo4vA0ZenKFDUYGAM5P+9GS3JAj34J7DPBaqDE2SiNU
         ite0bRPHbUw3Y8ee1Upg7gc420WgQhqsZEIeEqzU8kvWAGT++c3eD4xrwD3QvaeT7Dpa
         F5tw==
X-Gm-Message-State: APjAAAX7Dft2u5H6hDlFJFelg45C337jIsMjfNmlT6pfUV1CBKgNUByb
        aWVViVREFg+3Jim1U338ZRQQQMTU3I/j+33SSPga0Q==
X-Google-Smtp-Source: APXvYqxQj6V0JsV1Wq1M4PK/ZqnLQAggZqvxwAWQtvoVxjTqMsgvXgRRn/MxQo0FX6SkSFdhHPKRHE9oRdeF58llyro=
X-Received: by 2002:a67:fb02:: with SMTP id d2mr12106614vsr.207.1563309164025;
 Tue, 16 Jul 2019 13:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-24-matthewgarrett@google.com> <5d363f09-d649-5693-45c0-bb99d69f0f38@iogearbox.net>
In-Reply-To: <5d363f09-d649-5693-45c0-bb99d69f0f38@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 13:32:33 -0700
Message-ID: <CACdnJuudpnaQ5YUhoxmxNWVdRB6v0u0Bf2O6NmYOXjp8_govyg@mail.gmail.com>
Subject: Re: [PATCH V35 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 3:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Hmm, does security_locked_down() ever return a code > 0 or why do you
> have the double check on return code? If not, then for clarity the
> ret code from security_locked_down() should be checked as 'ret < 0'
> as well and out label should be at the memset directly instead.

It doesn't, so I'll update. Thanks!
