Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC46C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6B206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeIQdxla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfCZS14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:27:56 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:49704 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732061AbfCZS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:27:56 -0400
Received: by mail-oi1-f201.google.com with SMTP id h5so5706879oih.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=I8m7o5W+KXgqL155yuBqKYkypPnZyCLZZT5sEKvSeq4=;
        b=TeIQdxlaEAnwJiziIOm4C/26mSLLjqSOehPpim2HMY7wW9ln4e77/vUYHrPe2Qsgtu
         n5/t9xcp4n0CROs+Z01AbnJYjLwqGAG9Vxi07V1AtKMjtcRrSsh30GOVYcNY2yR4h3wu
         Fz6wEamNMo1JgIQ2Afj63tuCVfURLFypB6AvVWMUkS6HuoOkEgfJazwviTZoTZ3pRIcL
         GPRhXPjBQYQzzVv27yD8x56v9wKm0IkBKnI76cJYbYNj2oI4OGSBBefZc5yVvNcbwTv/
         mBy5Bhx86xPb8rUZNmHora32OCSfPbdJbOaZoSUrDfFSf+bUMJsUYl8bsg6f83nADmPF
         o9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=I8m7o5W+KXgqL155yuBqKYkypPnZyCLZZT5sEKvSeq4=;
        b=Ch8FIYsOy57WesNqkBP3oiLeI6EwI9Bv8UxZMO4BAw53N7PvIRMneZP+YNXHdGYdwV
         gTiloh3sQoylSwykYh46FI92lvudieW8CZ22pB2OvdVAQfxFBRxpUKqixOnQ2wFOTfUD
         LZOQkRR1NUe6daSi0LFZ6d8wQAGr80W2Y237nnTRzcAdWi/VmYF5hVOekjSdsOFh2XOx
         y9IPZjJLHEnSqihf2yKZ7ffeoDNLk4qtCrEtCyHdRmX9scV8duvZH83g/hp9CYdodmXp
         +eo97a7F9m9+qqzWMVgvCribKdXiee2kkjbewGz81ZVaDpaxSCfPr8I7VWeZpARIvqXd
         k1rA==
X-Gm-Message-State: APjAAAXrkgKIV5IwbgQh8KAzd0P4gXUpa/TcohnU185CynHuj6gE5AJ1
        8a1XLaTjmhBIo7r/yAxykj/VZX4CtxfgpDEgV+PKaQ==
X-Google-Smtp-Source: APXvYqwfKZWimNq2mn2Y6T+dsHydtEbaYSfOjjbKlTpgKrK+uLnXYOCGvh9NhG/DbETd+vavN4vYPhn38s4TdSuwtoTt9w==
X-Received: by 2002:aca:31cb:: with SMTP id x194mr16782535oix.71.1553624875808;
 Tue, 26 Mar 2019 11:27:55 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:16 -0700
Message-Id: <20190326182742.16950-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 00/25] Add support for kernel lockdown
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates: Based on Andy's feedback, lockdown is now a tristate and can be
made stricter at runtime. The states are "none", "integrity" and
"confidentiality". "none" results in no behavioural change, "integrity"
enables features that prevent untrusted code from being run in ring 0,
and "confidentiality" is a superset of "integrity" that also disables
features that may be used to extract secret information from the kernel
at runtime. I've also modified the bpf patch so that only the calls
documented as giving the ability to read in-kernel data are locked down,
rather than all functionality being disabled - I'm not a bpf expert so
would gladly go for further review here. Long term, it'd be preferable
to be able to tag secrets held by the kernel and grant access to
everything else, but I'm open to further feedback here. And at Greg's
request, debugfs is now largely disabled once the system is locked down.

In the general case, I'd expect distributions to opt for nothing
stricter than "integrity" - "confidentiality" seems more suitable for
more special-case scenarios.


