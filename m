Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896F2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69D20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6AKQk9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfHNAfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:35:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40812 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNAfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:35:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so52131324pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 17:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=HSL5yZkTigtq3mHBSL2omFvZGh6CImDi2PzvazVrMSA=;
        b=J6AKQk9kFqoP46HdODtVDss/nseRY9JpwV1IdaYSlMxP+KC/WBz1CmyoF1PaVVeczI
         OXweYNBx9VKchVNzzzmErWWIKcXpvZdZM4awFR8bv9dmi+fymrreeh6UK9yb0Sid4hd+
         4opyabtLOKVe6fYfQNDpitVl+My445gNlxCEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=HSL5yZkTigtq3mHBSL2omFvZGh6CImDi2PzvazVrMSA=;
        b=mpHjUPn86N0oDMc1pho1GdTAm6MNlCnGEQlrFUZDCP+73P+Yq0wUCt7ogsAUOh+veq
         oGKej6CbQMFeLcCQ4N5vnUky1w2GqMnR0O1Jw87SzKYU2y2ERE6Yr54wNCwGw0ObDGa0
         myekUDcw6aldhuDfEX9irSUBQg+BKVB1pgkrZ6p5cq7OQb1fiadnggNA1aD526rsnje5
         Fjlh2vhYofXttbYv68Otxli7ya9ToU3YiL8n2+NMJaKXht/tLzv6WhsC1o5kG8NyU0MU
         Rvd8Udfzlrd/daSsnU1s0umgXJVj4RSLdgetdeM7S4swhGs9p7lwVWXrCnt2B1AshTqx
         Rjdg==
X-Gm-Message-State: APjAAAWFLO02La8f42yK66udWpMCEr9DO/v4PKanl01U3VbNvEJvy5FV
        8AGIjUrlEhvaTs4IqsrFNTYnHQ==
X-Google-Smtp-Source: APXvYqxAGnfVcezj+08pwGn27gLP7EWedroG7GpvZ839EhiYhNye0C/BovLgfSe3r7eHTWjRd6o4Qg==
X-Received: by 2002:a63:8f55:: with SMTP id r21mr36428314pgn.318.1565742911670;
        Tue, 13 Aug 2019 17:35:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cx22sm2329301pjb.25.2019.08.13.17.35.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 17:35:11 -0700 (PDT)
Message-ID: <5d53573f.1c69fb81.a2ac0.65f6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565731976.8572.16.camel@lca.pw>
References: <1565731976.8572.16.camel@lca.pw>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:35:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qian Cai (2019-08-13 14:32:56)
> The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [=
1]
> introduced some baddies during boot on several x86 servers. Reverted the =
commit
> fixed the issue.
>=20
> [1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.co=
m/
>=20
> [=C2=A0=C2=A0=C2=A039.195053][=C2=A0=C2=A0=C2=A0=C2=A0T1] serio: i8042 KB=
D port at 0x60,0x64 irq 1
> [=C2=A0=C2=A0=C2=A039.197347][=C2=A0=C2=A0=C2=A0=C2=A0T1] kobject_add_int=
ernal failed for wakeup (error: -2 parent:

Also, this is weird. Why is the kobject name just 'wakeup' and not
something like wakeup0 or wakeup1? This is why we're seeing the lockdep
warning happen after, but I'm not sure why the name doesn't have a
number associated with it.

