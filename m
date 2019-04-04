Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7F920855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtUZHIPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfDDQCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:02:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38763 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:02:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so1591358pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=S9Z4DUxs9dJUOb/qPKK1ecNe8uJr9KFVVyK3mX09kEU=;
        b=WtUZHIPGrmYygFSSQIFNmBsJkW0nihcORt65SMKfVS7SXtZVHeB8adxBzuFYC9Rsbk
         wfEQIZkQa//gRXTNOoD4SntcvMQ3YpbVzvdRF9kSTY33ET/6b6kTH+ESW7b90KhURAc+
         V52KhlRp0e752lJGEze4YBWwescemNxHv9lhw6VUfug79Z44EN4lxgWCXhowRHw8nNr8
         KOfKE7jw5Vr8IxRngAIdJaUZ1MStxcpcXq8GRuknDWoXsIK0e7mjMaQm+nMLUF2za/Ky
         EBsYpR+UMlf0L6NmuOwijWZeHZ9PqcTksJxjXj4vujl9s4kvZ6DaBDmKWVtW1fe6wI4l
         IyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=S9Z4DUxs9dJUOb/qPKK1ecNe8uJr9KFVVyK3mX09kEU=;
        b=TeiTfk1XrwiPIcG2yl8J57Wk3xqWZkh7Gzfjb+Chj+D7eMpRSbaPGX4pKitLG/l5PX
         XiSZtwFXifaOxBRxg+HqvschwyxfNzpaXz24hEaPX/MRoiwu8F6lrcyfhPlolEBkiIza
         q6hYrBND8/YsJOEttJPvblvMBTxeSjZWq3hvrd+/JfQetBH32TTxiMhXrA0p25Z2NFge
         MbTTO7FtK355mya7piXXvYCT1qY48CTvyzi1EJZyGmn7YtlE/8iPAWzDL5Xe4ftZb+bn
         1iQXjWF+LpH8h+O0KWH40acX+D2SWtjNPyqocQFyrG00XJQ1DNmlHTvv8r2MeGHeZsl/
         pJdQ==
X-Gm-Message-State: APjAAAWQbqULSs0G/wGgI/u8wnHKiPptrKlNwH0ivGTP2TkB3omSqV04
        gK5DNchx6RxO4ezXxIB7mVE=
X-Google-Smtp-Source: APXvYqy4pPeqK6wTklVM59aPgCdxRXVJ8t8YFk5FFn9vocJjqtWga8w2asttK7Huy/4S7WeSVk42SQ==
X-Received: by 2002:a63:f74c:: with SMTP id f12mr6557455pgk.124.1554393766737;
        Thu, 04 Apr 2019 09:02:46 -0700 (PDT)
Received: from localhost (193-116-89-42.tpgi.com.au. [193.116.89.42])
        by smtp.gmail.com with ESMTPSA id 4sm26475701pfn.159.2019.04.04.09.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 09:02:44 -0700 (PDT)
Date:   Fri, 05 Apr 2019 02:02:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/4] Allow CPU0 to be nohz full
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20190404120704.18479-1-npiggin@gmail.com>
        <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554393113.wbjxx9ccdx.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner's on April 5, 2019 12:36 am:
> On Thu, 4 Apr 2019, Nicholas Piggin wrote:
>=20
>> I've been looking at ways to fix suspend breakage with CPU0 as a
>> nohz CPU. I started looking at various things like allowing CPU0
>> to take over do_timer again temporarily or allowing nohz full
>> to be stopped at runtime (that is quite a significant change for
>> little real benefit). The problem then was having the housekeeping
>> CPU go offline.
>>=20
>> So I decided to try just allowing the freeze to occur on non-zero
>> CPU. This seems to be a lot simpler to get working, but I guess
>> some archs won't be able to deal with this? Would it be okay to
>> make it opt-in per arch?
>=20
> It needs to be opt in. x86 will fall on its nose with that.

Okay I can add that.

> Now the real interesting question is WHY do we need that at all?

Why full nohz for CPU0? Basically this is how their job system was
written and used, testing nohz full was a change that came much later=20
as an optimisation.

I don't think there is a fundamental reason an equivalent system
could not be made that uses a different CPU for housekeeping, but I
was assured the change would be quite difficult for them.

If we can support it, it seems nice if you can take a particular
configuration and just apply nohz_full to your application processors
without any other changes.

Thanks,
Nick

=
