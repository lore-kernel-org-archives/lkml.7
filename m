Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A27C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516A020840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fCjKeF9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfG0LsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 07:48:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42403 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfG0LsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:48:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so55240595qtm.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3QcusByxnBLEAwsrMGgC+4eQjoFDrnykdiClscYz6rg=;
        b=fCjKeF9+kIWLJsh5NY0adar+npSdusjEbiBOdDLkMLWFNgXvxvOcUbvLse7dGRcQag
         BME+G1RBmmri5esgH8la40Lxb8Z+wUKfryfwU3nPESK9lRIOME80o1IfprMlShFGeOaL
         lM/pAY5AJscBJ3DIIVbal01jAxMmkMP53HyXZgjnxJ9o64Z68JGdb9Dny4Irx93KiVPt
         bY73e8cBLldad9kzE8Z0Px7tw2RH7iOzKRoJ9HzECeV+L+bvN50WC4dHabCB0eFo+Vwr
         mUQsG/tYvDHrGz0LBfoo3S0FsEB0jrzDw7fQ/OO2SkW38PW4brFUDekWsYuwRMTDMPQW
         bCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3QcusByxnBLEAwsrMGgC+4eQjoFDrnykdiClscYz6rg=;
        b=YReAxmirOmd3PaEIeL30GKDkm2QaLGUKjFVFQW1b10Kxu64vLCFVbk3UXqwvorgVBe
         QVwGQQx0UOv4u7Cq2aYEJ1WAaOGNPD1Z59iob1qBnBwT2hsKdliVWKTSCQ+fBSi7DVRG
         2pafqoFwRXxJdj/ykMalhH6kvHCmWqMIu/ykzaPiWhOBcNV9TVUGAj6VEifdazTkn2rw
         5KzPGR5wZKF/dndIwTSPL8G2PAkAc7MioegIiDwAE6Avg6oVJGvo6rboF8tqYNmVkAkH
         Ucn7M6xzOdBzOsRIkqZ6Kj0l85xTmuPnm+AHqJFuERzFDlrbOUtwTOqzi/RTR/3j9XV+
         IPbw==
X-Gm-Message-State: APjAAAU2XuiX+YaSOArS1IUmwltAukw/b9I1PBt2a36Q8Za7kjKfwfSD
        ayciKj8IBkECLGd7NB+6r1WZaw==
X-Google-Smtp-Source: APXvYqwhYpOWEJA6y7KtdbabIBqP6vNi7PHVTa6ERXqKtsvLJNqqB0E1lHclFWVXE5cfyitHXd0R0A==
X-Received: by 2002:aed:21f5:: with SMTP id m50mr70103521qtc.66.1564228092972;
        Sat, 27 Jul 2019 04:48:12 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q32sm23811313qtd.79.2019.07.27.04.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 04:48:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190727101352.GA14316@arrakis.emea.arm.com>
Date:   Sat, 27 Jul 2019 07:48:09 -0400
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@suse.com,
        Dmitry Vyukov <dvyukov@google.com>, rientjes@google.com,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00205B2E-36E0-4169-997B-B9A522482CD1@lca.pw>
References: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563301410.4610.8.camel@lca.pw>
 <20190727101352.GA14316@arrakis.emea.arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 27, 2019, at 6:13 AM, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>=20
> On Tue, Jul 16, 2019 at 02:23:30PM -0400, Qian Cai wrote:
>> As mentioned in anther thread, the situation for kmemleak under =
memory pressure
>> has already been unhealthy. I don't feel comfortable to make it even =
worse by
>> reverting this commit alone. This could potentially make kmemleak =
kill itself
>> easier and miss some more real memory leak later.
>>=20
>> To make it really a short-term solution before the reverting, I think =
someone
>> needs to follow up with the mempool solution with tunable pool size =
mentioned
>> in,
>>=20
>> =
https://lore.kernel.org/linux-mm/20190328145917.GC10283@arrakis.emea.arm.c=
om/
>=20
> Before my little bit of spare time disappears, let's add the tunable =
to
> the mempool size so that I can repost the patch. Are you ok with a
> kernel cmdline parameter or you'd rather change it at runtime? The
> latter implies a minor extension to mempool to allow it to refill on
> demand. I'd personally go for the former.

Agreed. The cmdline is good enough.=
