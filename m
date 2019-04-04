Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F6EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C642171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfXx0w17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfDDNsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:48:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33533 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDDNsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:48:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so1952928oii.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FyQmOe4LX7CfZwLl8iRSUR92OpcJUE5HTIj09zBPW10=;
        b=EfXx0w1710q2tTMeC28+7Ptb66JVsgcvbPYktEJXH+/K2jV/bbENp3a9OHIlTpqRGS
         QaEYutMbP7acKUj7jI+LihAs7uhUeGU823M3gcjIHZx1sbhDsKj5JAqeNwyDhdb+c5BQ
         PuWkzYZKlNEkjyJ59g1XlpJwYw6iOf8HNnPbMCVecsNqcfuy6KakK7+vj8AsbNIxszQx
         WCzolQG49cmcNlXwAGGVp2Bm3Z+01WcbS+ayioevYQxJ3Wiii7wTF58otgrhYw64mw4k
         ADzs8DFFDIIPR+t+Ee0eRfCVkXlo/PF0tyIEUOxshM7c/sI0HYq9vNcZfWuDlVJOm8RV
         KvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FyQmOe4LX7CfZwLl8iRSUR92OpcJUE5HTIj09zBPW10=;
        b=YOh892vPWP3kXutBFyXdg17BbDfH+3m7hGOqgidXjU0IzojbWFDRnQrj9vRe+ArVX+
         56ccpDWKjjAPlOiDYgTBJlKhP0Chz3ZAAoK6YhGWKcjDQWSXgJZSu21l7kosvMicYvSI
         OHOvao4WPeWd0EQQulfV1NxAngRhJUadD2f2ync7FiSS51nA3b9WqVo0LpWol5lL6fBk
         Z23YeXkIXOy/lUqE7m68uBuVQ93suFr2T1H2QGsZAitBGd8EKGZTGaCaLqM5WQrqkqjz
         B0MncqotYBT0ah4S5Dmkvn7F8RGJgSWCLS3v90HV5rxH7Sh60ulap+CFSl/+2T2Kmj2O
         lqMQ==
X-Gm-Message-State: APjAAAXpaoOU+0+1a0+a8h0HHlpwayQIXL6+nkz+ibrgiH/Rz8/H7ZiF
        kMd2LSG2dZbE1KeZi3W9vflgjC5xYgfUP1yDzoFqbw==
X-Google-Smtp-Source: APXvYqwyGeo/i3iJNW95FFhCRryHa2m2sI7SgQZ1tjNsM03/zCyncKiMZAjuKOLzOGTvBIAarHAfUdbKvyxCvDTOyd0=
X-Received: by 2002:aca:d487:: with SMTP id l129mr3647979oig.129.1554385700842;
 Thu, 04 Apr 2019 06:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
In-Reply-To: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Thu, 4 Apr 2019 09:48:04 -0400
Message-ID: <CADVnQy=hsPrDwXoym18j7YzCc36669NJ1kVBR76y+FgK6Meytw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
To:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
Cc:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 8:24 AM Tilmans, Olivier (Nokia - BE/Antwerp)
<olivier.tilmans@nokia-bell-labs.com> wrote:
>
> From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
>
> RFC8257 =C2=A73.5 explicitly states that "A DCTCP sender MUST react to
> loss episodes in the same way as conventional TCP".
...
> This patch replace the clamping of alpha by setting ssthresh to
> half of cwnd for both fast retransmissions and RTOs, at most once
> per RTT. Consequently, the dctcp_clamp_alpha_on_loss module parameter
> has been removed.

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks!

neal
