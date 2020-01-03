Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E61C3276E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F61F2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXRjaTQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgACBU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:20:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39964 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgACBUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:20:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so22833317pfh.7;
        Thu, 02 Jan 2020 17:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iPY8DonFEvaslZITm1PPK8VeIN05fhFDyPqLfWySPpI=;
        b=jXRjaTQwgRDYEVu8ADx9goMMyad9kCOAIf4eUg61yAVUcLwjnjGNBDBdK/eFHOy4qH
         hJov6B6ndqk+qNScsR9poV+FXGN8zh5L2yxQJIfB0fpLo5VRxBADw0AwpIZ5fnT+Hz38
         wvIOWK8aqUCCdh6jNg449gb7xfJv0ppdbP32xULiMZ9ymmdhlQAYH6pzm/yp1JItJye/
         1Rk+rR2aUB2o4OEMF9UYNrY2zZckoB2LMZZALfHWJJNvu6362qKLWC5Blq4lWOqncJOO
         4erFENLSObRkafLTaS5EcQf+WEsPdmNH0Eki6WDL3ygsI42KeF0N9IGp/MpAozHtIUfz
         RR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iPY8DonFEvaslZITm1PPK8VeIN05fhFDyPqLfWySPpI=;
        b=ChUICEPsBFrG4k1aSHmUMUWVFOwGu6xo9ycJ3GNKFY6TanjFZTdTOE5d5ylSUdbHSD
         SFRQdjgmuzXl0M/C2Or2ncgvSAd99DuwVjkEqZNaTs1FbcJ+/H7vq70zAq99TbHcC7zJ
         ESLIA+x7QuOqq0cpsA4CV3NVBgogWPtJIRYVGMM5IFPzL4vaT2j21XN99Q8GH0G5v2Yz
         yz+Ikcvv8X9NWj2cccwNdVoigsMpcts7EoIl9v+Qr38SyEVoPlcaTtjX8xwC5xBbf0ks
         7BdtjDRGIx16buWEXrDmyZY+C3fJHtA4g+D06DlDw5r01V3rDmK3If8hQrjKvlIuO3lO
         zY+w==
X-Gm-Message-State: APjAAAUsBoQkad3oGF0UiKbKWqh2ntd30sGe2RrajdUZCeiIga+a/XQw
        JUYTeqeKNrfUNRP7qnNlyEA=
X-Google-Smtp-Source: APXvYqxd6ZxVhx9DaLcQylwATIY8jZP4Z3jP43AFyDvRtje352jdjg8y/Sjwo4w70QrE7otE6EFQ1w==
X-Received: by 2002:a65:6794:: with SMTP id e20mr92694645pgr.152.1578014454937;
        Thu, 02 Jan 2020 17:20:54 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r37sm12215963pjb.7.2020.01.02.17.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 17:20:54 -0800 (PST)
Date:   Thu, 2 Jan 2020 17:20:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: st-asc: switch to using devm_fwnode_gpiod_get()
Message-ID: <20200103012053.GA1968@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_fwnode_get_gpiod_from_child() is going away as the name is too
unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/tty/serial/st-asc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index fb6bbb5e22344..3a533a0f172bd 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -566,11 +566,11 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 			pinctrl_select_state(ascport->pinctrl,
 					     ascport->states[NO_HW_FLOWCTRL]);
 
-			gpiod = devm_fwnode_get_gpiod_from_child(port->dev,
-								 "rts",
-								 &np->fwnode,
-								 GPIOD_OUT_LOW,
-								 np->name);
+			gpiod = devm_fwnode_gpiod_get(port->dev,
+						      of_fwhandle_node(np),
+						      "rts",
+						      GPIOD_OUT_LOW,
+						      np->name);
 			if (!IS_ERR(gpiod))
 				ascport->rts = gpiod;
 		}
-- 
2.24.1.735.g03f4e72817-goog


-- 
Dmitry
