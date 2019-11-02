Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7298CA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 03:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3FD21897
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 03:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rujAWXWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKBDHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 23:07:34 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45009 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfKBDHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 23:07:33 -0400
Received: by mail-lf1-f53.google.com with SMTP id v4so8517871lfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W30F2x/xesfK93BuIXjG/szWVIyAP5xi4+A90K/f+hY=;
        b=rujAWXWj5Yl3jAfKY+q/MG2n+CoppKqen4NamtrysKRD8HHEhrhRb8qYPleAA0w5ZH
         tkYNE8bFktGNHfzpL4eSzllwkNG+ilPznobSPC7QE5IZQkLY499zFT9dagzKqs0A6S4S
         PQmcRKRlusb9bCw0vjwK/EjHqneDe8YFColAuaTtXnAQDGe3s/2c3sX1N/SQ5zzEQByE
         nLUDkXRKjZxzo4eoaesD3WZZZuK+KVDe4VgO0RuHcAgVwx18COIkaCK/kdoDD5kCwJea
         bIE5JOpVe5BvigSBtJtxzowrYEZ86sEVpR7nHwTxR5RVyKthGMIK4Vz3OSmFYwnbNKIQ
         WDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W30F2x/xesfK93BuIXjG/szWVIyAP5xi4+A90K/f+hY=;
        b=U9KQA/ISpy+zpDdc4JJm4vRVSdcxu83nyeouKoJHxrnpUZnN78jbuI+XwSDqpifZOX
         tWlCFhsXYyRf0amzbpLc6lbsQKqKHd2DEPJbnJ6qtoC0fSPUj83ay9AvVxeCDWUX67OW
         sc4ly5oUnRAGLr43cL1u53zD3cpWh7z8w4K5I1gRWZW7JnwkBKYxYOx3S3zhVqPt+k03
         77a8lTO6MtOmTt4fYLYbrUaMC8ggUHcIoNELPgjMkCw33zqQshrbaVm33ecs13gP7osq
         sMQX6XeZCJtkfdaNW9DgmeBCtPQbWcJy3c2uUUtwVMqikF8aP8H/XkjuWCZrnRy7KmYB
         KpUQ==
X-Gm-Message-State: APjAAAUWai953lfkFl5xvQj17YI7UuQv0DKU7U2l88GvQYPYYlAET8Rz
        UV3Ns8YeN/3gkI7/2N2bBy/EYHIUKF0hCijNIdb21Q==
X-Google-Smtp-Source: APXvYqyx9z7WWesg2+wLHiJVtsh50hS+hR6IVoZSQW5Mt2htON9/2QOHFjzdkPe/WFW1+bROKle0g7ohOfXWeY/S0M0=
X-Received: by 2002:ac2:569c:: with SMTP id 28mr8497250lfr.139.1572664051644;
 Fri, 01 Nov 2019 20:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6QMdwgjCC7SmM=G=_aMVk68zP-t+AQfwVM8LWUDk18uCSURA@mail.gmail.com>
In-Reply-To: <CAO6QMdwgjCC7SmM=G=_aMVk68zP-t+AQfwVM8LWUDk18uCSURA@mail.gmail.com>
From:   Srinivas Murthy <the.srinivas.murthy@gmail.com>
Date:   Fri, 1 Nov 2019 20:07:20 -0700
Message-ID: <CAO6QMdwwJBR8GnpHZo=viA4qj8HN6QOS4+pBQwvHu28E-POnTg@mail.gmail.com>
Subject: how to find thread that fork'd the current
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the current thread (in kernel) is there a way to tell which
thread fork'd it?

systemd -> proc1 --fork--> thread2

thread2 detaches; thread2's parent set to systemd; thread2's tgid set
to its pid;

I see that the detached threads have their tgid set to its own pid and
its parent/real_parent set to the parent systemd

Is there a way to reliably tell the parent proc/thread (proc1) from
thread2's current (task_infostruct)?
