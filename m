Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A460C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08D02190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="J7zvin24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKKMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:21:51 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39856 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKMVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:21:51 -0500
Received: by mail-qt1-f176.google.com with SMTP id t8so15444418qtc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 04:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kGsoe4Atbpfni9wOUthL/jTmj/wlwUPm7rGUuETvQMg=;
        b=J7zvin247vYRdKA9elz64p2Lw390qlW+3+JDDCvZwpQGHqm+i9iwERx5bUMi65zJ5l
         eb/cJJXsZO7Z8J8w7+bLO20P1ah9hZu5GheCKVxUo+bPmgZH+ilec7uKPBTPauL8COZZ
         u0NU34D05ivibxLtJYmOWq2CwfWzHzFcLnLTaW8Hdi6+lU/lu8f+bpGbbj0eGZK89F0K
         RYEvcfh2wVTY0ISKQx9HVWgTKIXMAzLzSy6N/eoaF1V+wOaXPvfOh9ZwOmNsW7Lhwrs5
         flb1SXhjZutZc+pC08cVJXBTOmIRDN/VzNvNIphK51x3NQEjgBETeSkXSwDZPdZrGrwJ
         G0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kGsoe4Atbpfni9wOUthL/jTmj/wlwUPm7rGUuETvQMg=;
        b=PW801JGf60Eo0h/l39wK7VL8A+6sfGD6htiBxA44rpWREjuTm22mco1quIhprxFtBJ
         a7elAeUDmerWC3cCMUneldSna/+fkiz6YO4ZaxPsxw9GQTB0Zuv9M0F6r3elO6oVUdq+
         dPWFOklN2CEj/UguBVB0eKm8vfjoFvXwYJk97rwUwqruumlZ9jCvCcZ64Ib3f0G+soMS
         L1DFb/Eg79mxSuohFIG5+dm7i3SU4Y61OrPMgWgDUACzl6o0yEYhLrsVfVJo4bJNS8sd
         SNVtUNWrjDgpcSFBtZdBxNFjTobrAb7Dmz5AMZp2Dymys+R32UbR+lfwBiiRkKTADnQB
         IE8A==
X-Gm-Message-State: APjAAAW184CBZCrdV8KKuAoDqpbB8IBWCv0fLMcmY7Bib7oDSeFv5JDa
        opeAeAqDECPu3nD/jtojZCnwzhyGWKqexamUmKMRtw==
X-Google-Smtp-Source: APXvYqyJC60clMJ5Mo+afkfyMQQDDgG4yKyDaDgYSbQeP9iWnvF77jbf89jgqZCnGYSFBLvzhxWbS4sohZPNdjdE/j0=
X-Received: by 2002:ac8:605a:: with SMTP id k26mr23636305qtm.212.1573474909348;
 Mon, 11 Nov 2019 04:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20190826151640.5036-3-flameeyes@flameeyes.com> <20191103160030.GO1384@kitsune.suse.cz>
In-Reply-To: <20191103160030.GO1384@kitsune.suse.cz>
From:   =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>
Date:   Mon, 11 Nov 2019 12:21:38 +0000
Message-ID: <CAHcsgXRtWAt0mEQoW2rn1v6yYZ8ZKygKVetk4mnm_o+pwgwcVw@mail.gmail.com>
Subject: Re: cdrom: make debug logging rely on pr_debug and debugfs only.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 3, 2019 at 4:00 PM Michal Such=C3=A1nek <msuchanek@suse.de> wro=
te:
> can you change cd_dbg to a macro that always prints the device name
> using pr_debug instead of removing it?

I can try doing that (need to figure out how, of course.)

Should I split the change that removes the debug parameter /
ERRORLOGMASK parts? To be honest those are the parts that appear more
of a duplication than the macro itself, so it might make sense to
remove the custom debug selection, and then add the device name on top
of that?

> Also consider adding some relevant mailinglist to cc. I think the
> MAINTAINERS even specifies linux-scsi for cdrom and/or sr.

Ack, will do that, sorry I appear to have missed it :(
