Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A7AC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174B6206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562031997;
	bh=W6pjPEN1zb8kE6iBBaNfrMROGIiYPyv9aeswfstgqaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cqIOSwC0VpJ9znIQmUDsTZ5eyhDzndg8YQgYM/CRzulqt5IcvqkZpdrbWw+yI1nT5
	 +nFMr9NBxEB49hK07Gk0Mv7U3ue6+kteyvYDPVawW3tOEjnYRakTse0X9bxu+OYqo/
	 1Gn3Rvy81W1Nm+R9jtTcdkXpnGBAcyvd+zGYCClU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGBBqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfGBBqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 21:46:35 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2567E216C8;
        Tue,  2 Jul 2019 01:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562031994;
        bh=W6pjPEN1zb8kE6iBBaNfrMROGIiYPyv9aeswfstgqaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tmlLetHX7qUM5gy9CoM0JFxzX9V5kbOpnU8ganfCcWXei3UDuyOEMfvo1WXx0HyUO
         kUl5dT7nfBQ/umRpSPvl21AqOoTpbRjtTuiLtwhA7ABlAowOj8QRfBBER6Rb0LpAOt
         MM39r1+NnnEYoPwz9tB+KcstSgOGq3MAj13gUN8k=
Received: by mail-qk1-f169.google.com with SMTP id a27so12708728qkk.5;
        Mon, 01 Jul 2019 18:46:34 -0700 (PDT)
X-Gm-Message-State: APjAAAV4Q49UPHYuvI1nfJJiqVmsOt7kt0IPsSd+cPl/M7RxICeg4HKZ
        PvMKAIGZ+dr0ywWGi4WRJM0en7fq0rCZz0V4Nw==
X-Google-Smtp-Source: APXvYqyO4fq7/XDICiyTEmPfX78SUcw7GW0uwDF4z4pRcD+lOjUKdBFtKCIzH5A/3qa6J+VPCJ441+qp0WMnH7PWlmU=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr23718623qkl.254.1562031993399;
 Mon, 01 Jul 2019 18:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com> <20190702004811.136450-5-saravanak@google.com>
In-Reply-To: <20190702004811.136450-5-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Jul 2019 19:46:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKAn2uD4DC2wqJtkqLTFJ54yG_qaQjgfg=YrQfSEhJw+g@mail.gmail.com>
Message-ID: <CAL_JsqKAn2uD4DC2wqJtkqLTFJ54yG_qaQjgfg=YrQfSEhJw+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] driver core: Add edit_links() callback for drivers
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 6:48 PM Saravana Kannan <saravanak@google.com> wrote:
>
> The driver core/bus adding dependencies by default makes sure that
> suppliers don't sync the hardware state with software state before all the
> consumers have their drivers loaded (if they are modules) and are probed.
>
> However, when the bus incorrectly adds dependencies that it shouldn't have
> added, the devices might never probe.
>
> For example, if device-C is a consumer of device-S and they have phandles
> to each other in DT, the following could happen:
>
> 1.  Device-S get added first.
> 2.  The bus add_links() callback will (incorrectly) try to link it as
>     a consumer of device-C.
> 3.  Since device-C isn't present, device-S will be put in
>     "waiting-for-supplier" list.
> 4.  Device-C gets added next.
> 5.  All devices in "waiting-for-supplier" list are retried for linking.
> 6.  Device-S gets linked as consumer to Device-C.
> 7.  The bus add_links() callback will (correctly) try to link it as
>     a consumer of device-S.
> 8.  This isn't allowed because it would create a cyclic device links.
>
> So neither devices will get probed since the supplier is dependent on a
> consumer that'll never probe (because it can't get resources from the
> supplier).
>
> Without this patch, things stay in this broken state. However, with this
> patch, the execution will continue like this:
>
> 9.  Device-C's driver is loaded.
> 10. Device-C's driver removes Device-S as a consumer of Device-C.
> 11. Device-C's driver adds Device-C as a consumer of Device-S.
> 12. Device-S probes.
> 13. Device-S sync_state() isn't called because Device-C hasn't probed yet.
> 14. Device-C probes.
> 15. Device-S's sync_state() callback is called.

We already have some DT unittests around platform devices. It would be
nice to extend them to demonstrate this problem. Could be a follow-up
patch though.

In the case a driver hasn't been updated, couldn't the driver core
just remove all the links of C to S and S to C so that progress can be
made and we retain the status quo of what we have today? That would
lessen the chances of breaking platforms and reduce the immediate need
to fix them.

Rob
