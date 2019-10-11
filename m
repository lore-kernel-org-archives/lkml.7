Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B5C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB842089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7R4O2oD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfJKOxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:53:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34949 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727382AbfJKOxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570805619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0gWaQdKujjo5Z3ROPjLS3LoyD2z5QHy/ABRibObpfXs=;
        b=N7R4O2oDrGcXAjVMlGIsGQmQWq9aiEZcu1Bp72Ed+ipB9OC0qj5ChPoImRZ7bFBKbMCKU2
        P7B/Txqp/uKuPz3rMnq7/jPRb3uit8YGdA6uz4Kt4fzKoJOiNCnoncmUaAN7Qvy+j3WeF+
        g9cFtXLvT9amicnzkgkFRPfR7XmCQt4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-O5T-1JEuMD-ws9NAGen2lA-1; Fri, 11 Oct 2019 10:53:36 -0400
Received: by mail-qk1-f197.google.com with SMTP id x77so9149349qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4I7np6p5oqe7yeeh//OBr5xu9S8MBxRhjeAjpR7a98I=;
        b=F7a9gc1qIbeVuA0NqqGAXEM45s33Apx8y/bHLES/97M09Nmp3cbHg1Ov/VIxTRZhUm
         Cf5Ug+pU1BggqQAvjeu1HyqG/G6lDZfc4nIfcddgjjz4Kd8FnewI0QL65tVlFph1gdQ4
         +fmDbYnSWdw0VsroXnriFZrDqTWR+ICOTzsACxu3+O9PAQLW+7aZcUu6Yw/PGYYgFmru
         uridxXSr48twdC0Fn/aS6y1P5F3eusa3AxTCzdyGacQuXd1nNJNO4JUaBrUIDo+nfyav
         8Al8cfoIt74Hqgcf5m6L7wKYnG7vEUZWrsxc89o9KtFa2RFGDh1/zlVEYjkeMLogz5BO
         SL/g==
X-Gm-Message-State: APjAAAWn4XG/ckWHfvWj+vq3O1XiE6O2tGw8KST+RBHF2uz7GZ0URZvN
        beRvooAtVlmCWsnS9ehrwF0c/9+dr9ScKqRVNrBf191FoQS+qe6OkGevNRYe8cj9VR4WMpBQI+d
        qN8OXbge5UgGDfI+96g2IJV3a0KSxj0jSRKS5mUL3
X-Received: by 2002:a0c:fc4a:: with SMTP id w10mr16601147qvp.46.1570805616124;
        Fri, 11 Oct 2019 07:53:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGwQJCiAxjvuWtw/ewNFYWdVm3XJoE5QGghOEG7vmbVbwQO+m3I3TFA5aGujRnet5l8V8u+HrcAzmhv1JM2xw=
X-Received: by 2002:a0c:fc4a:: with SMTP id w10mr16601121qvp.46.1570805615825;
 Fri, 11 Oct 2019 07:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191007051240.4410-1-andrew.smirnov@gmail.com>
In-Reply-To: <20191007051240.4410-1-andrew.smirnov@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 11 Oct 2019 16:53:24 +0200
Message-ID: <CAO-hwJ+=pDmvPbLVO8mViygJof7O1YeX3KO951nqN4dNaKz83g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Logitech G920 fixes
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sam Bazely <sambazley@fastmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Austin Palmer <austinp@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
X-MC-Unique: O5T-1JEuMD-ws9NAGen2lA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Finally, someone who takes care of the G920!
Note that when I sent my first initial version that Hans reused, I
surely broke it (looking at your patch 3/3), but no one cared to test
it :(

On Mon, Oct 7, 2019 at 7:13 AM Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>
> Everyone:
>
> This series contains patches to fix a couple of regressions in G920
> wheel support by hid-logitech-hidpp driver. Without the patches the
> wheel remains stuck in autocentering mode ("resisting" any attempt to
> trun) as well as missing support for any FF action.

So, you are talking about regressions, and for that I would like to be
able to push the patches to stable.

However, I would need more information:
- patch 3/3 seems simple enough to go in stable, and is clearly a
regression from the recent series. Can you put it in first and add
stable@vger.kernel.org in a CC field (and possibly with a Fixes tag as
well)?
- I am not sure which patch fixes the wheel remains stuck in
autocentering mode. Is it patch 2/3?
- was the "wheel remains stuck in autocentering mode" bug present from
on of the recent patch or was it always there since we introduced
support in hid-logitech-hidpp, but the game would need to unlock the
wheel first?

So all in all, can you:
- drop the first patch and push it in a later series
- re-order the patches: 3/3 then 2/3
- tell me when the wheel is not stuck when the series is applied
(after 3/3 or 2/3), and make a note in the commit message with that
information
- take into account my comments in the first patch you submitted (that
I just sent).

Cheers,
Benjamin


>
> Thanks,
> Andrey Smirnov
>
> Andrey Smirnov (3):
>   HID: logitech-hidpp: use devres to manage FF private data
>   HID: logitech-hidpp: split g920_get_config()
>   HID: logitech-hidpp: add G920 device validation quirk
>
>  drivers/hid/hid-logitech-hidpp.c | 193 +++++++++++++++++++------------
>  1 file changed, 120 insertions(+), 73 deletions(-)
>
> --
> 2.21.0
>

