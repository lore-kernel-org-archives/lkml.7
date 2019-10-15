Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E24ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2A2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571179153;
	bh=ZZ1tkLH6Evl6gaSnOj/4I8fnnuCBE15LMoxDF1dxmkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FkswXBx/xHX0goOtHc/LzCvOERey13Qv4Xromt20WHhjXc57C6sejQgQr4I1pErQA
	 7XBggBxjI6o01Va4+E+a8CJxBJz9ar3Wo9knPlMJbLN14mUMJMCeusuLegB74t+g0J
	 HW8YiyxRSKwEnY6xvAlCq9QBIJQvzaccYGVCmnTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbfJOWjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:39:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34539 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbfJOWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:39:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so21946343lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=SIEI+eyzsLvgKQSWy68fNU4waAO3JnvS6nzHr5/fZu5+F3lS+ninFSB5dUKCVryHZ+
         kl8H8QJRcmYfRoBpcYQdlcvyFYmbnE5AhMRuYRji7sgqsBgEDlqfBvGU7GUQWJu2UMf7
         6W/csLC8ZHTI+HN72RKiuRYhkxOOMexsvDhzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=tz2fV6+rx/OFuGnXohp9D2THamucFJGP7pymYrdMX6gWRLS4N8ZfkFXkfKDQ2Ejcby
         ItqSRhTdMSrNiZU2MqP3B+P4bd0VkNlID4/ivZYiIvcMViyINvfsbaurNVfgDhOdi+fg
         52EbAOMWLYd+KdViIVJOL/Z5C6QpjjlN0i6Kd2uvLdYrOpfCztDFUn8W1pdqHFlLMom8
         JRLNf/CK+qsoPo9XMCXwuHeLSg4b/nh3MUhJD8DEb/rEXIYef8N8A4cjKEjkFjIJgcDV
         oOlp9pCvUX1rL2UVyAMIJwpMnzcmtlyTBq43E4Q9njZDnww9zCi69GV2pMWkbp0zVIei
         E20w==
X-Gm-Message-State: APjAAAVEgC1F1UxqRMwNNeNY8wIF0MMN4hYZbTrzkgsRz23u9vI3Wrmb
        hUkgBHc7R/G900keU9sNT3aTEl2fquE=
X-Google-Smtp-Source: APXvYqzdGBZG1Ya5kS05O9OAlNXgBSsEz4FKifFhDRQxIZ7O5Ua0AgK1vBxHV6SXVSYD5dFLW8++wQ==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr13675890ljm.84.1571179149469;
        Tue, 15 Oct 2019 15:39:09 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id i190sm1271584lfi.45.2019.10.15.15.39.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:39:09 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r2so15728983lfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:39:09 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr4230778lfe.106.1571178744104;
 Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:32:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] pipe: Keyrings, Block and USB notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside from the two small comments, the pipe side looked reasonable,
but I stopped looking when the patches moved on to the notificaiton
part, and maybe I missed something in the earlier ones too.

Which does bring me to the meat of this email: can we please keep the
pipe cleanups and prepwork (and benchmarking) as a separate patch
series? I'd like that to be done separately from the notification
code, since it's re-organization and cleanup - while the eventual goal
is to be able to add messages to the pipe atomically, I think the
series makes sense (and should make sense) on its own.

          Linus
