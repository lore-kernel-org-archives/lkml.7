Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14928C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2CF2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cOIAd1Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfLFBob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:44:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59045 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLFBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:44:31 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191206014427epoutp036b6019148a428583f85fc737a0994713~dpNIvOjcZ2612926129epoutp03a
        for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2019 01:44:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191206014427epoutp036b6019148a428583f85fc737a0994713~dpNIvOjcZ2612926129epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575596667;
        bh=00Ax0PCvKZG1pWBE6T7SBs5uU2a4tB5xIqGtXQzy7Ak=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cOIAd1ZxI07ZUkvdJIQlqftNawa+bdXm+/j84MXkLswhwTzwSknk6WKpHmnMpHiXw
         qrvcxXEOh1m2S0TtJERSv4Y9EfiwsO/MIBtQBxvlii/AVj7NVpSCo+jDftOmrIC1kq
         QY4gNiMVIDvqWBFpUJwcXFyGW1ukRul81LTlN21U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20191206014426epcas2p164ab75af604a87a9f898554779ced0b5~dpNIPsvwI0639106391epcas2p16;
        Fri,  6 Dec 2019 01:44:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47Tb3r38yczMqYl0; Fri,  6 Dec
        2019 01:44:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.AC.24889.672B9ED5; Fri,  6 Dec 2019 10:44:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20191206014421epcas2p4ce83c029064c81d4f694ff9a4e3eadf6~dpNDhKabi1390313903epcas2p4B;
        Fri,  6 Dec 2019 01:44:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206014421epsmtrp1b25f2b7ddf59e9e61dd86b7be2261b5b~dpNDgZ5tX1904319043epsmtrp13;
        Fri,  6 Dec 2019 01:44:21 +0000 (GMT)
X-AuditID: b6c32a45-493ff70000016139-09-5de9b276b805
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.3A.10238.572B9ED5; Fri,  6 Dec 2019 10:44:21 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20191206014421epsmtip214094b6ec2629783a81fd14849f0ef39~dpNDUOfcW3031330313epsmtip2M;
        Fri,  6 Dec 2019 01:44:21 +0000 (GMT)
From:   =?ks_c_5601-1987?B?sbjH9rHiL0hZVU4tS0kgS09P?= 
        <hyunki00.koo@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     "'Hyunki Koo'" <kkoos00@naver.com>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kkoos00@gmail.com>, "'Shinbeom Choi'" <sbeom.choi@samsung.com>
In-Reply-To: <20191205160243.GA757198@kroah.com>
Subject: RE: [PATCH] tty: serial: samsung: support driver modulization
Date:   Fri, 6 Dec 2019 10:44:20 +0900
Message-ID: <000001d5abd6$ae5a6b50$0b0f41f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFi9qlUO8Ctq9T0Z7HzrAiawnl7JQKQ/Hb3AgWTdE0BtEDdDAEeJiFjqFZ1VCA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0hTURTHu3vzvTdr9ZpWJytdz4gSrL3l1ltkBZUtijL8pyJZD31Ncb/a
        2+wnZFRTo6wo/DGVRoWRhdqy1CKzGVlgBlmEmZWooUWi/Vi/yNr2DPbf557z/d57zrn3kpji
        Jh5DZlscvN3CmWg8UnqrdeHSxFzvULqqqDiSPXKxFmfP1Y1I2BEvyRY2vYhgnz6tI9jO2xU4
        237xJMG6Tr1Dq0h9k7uH0HurC3H9vcprhL6oOA/pi+qrkb62/oVU/8Ubm0psNy3P4rlM3q7k
        LRnWzGyLMZnekGZYbdBoVUwio2OX0koLZ+aT6TUbUxNTsk2BomhlLmdyBkKpnCDQi1cst1ud
        Dl6ZZRUcyTRvyzTZGMa2SODMgtNiXJRhNS9jVCq1JqDcacrqGm4jbN+W7G346JbmoSfxx5GM
        BCoJfD1/JcdRJKmgGhH43wxEBBMK6jOC4c/rxYQfwZXnjdL/jvyHtZiYuItgrPMeIS6GEPR5
        ekMqnEqF0btleJCjqW3wu68jFMeoZgQtb6OCLKNUUDxWg4IcRaWAv7kSC7KUmgedbYMhr5zS
        wY8bfVKRp8Ljsv7xfdRw6ep5ichx0PCpAhOrU8LPgaoI8dxNcPjWVyRqoqG80BWqGqi/OIxW
        +QjRsCYg8iCRo+BDW/14PAaGTrnG+RA0u84QovkEgp8j4pCAWgLu9/kBMxngeHjwary4yVDQ
        +ocQw3IocClE9Xyo8Q9KRJ4N1wZuE6cR7Q5rzR3WmjusNXdYCx4krUbTeZtgNvKC2saEX7cX
        hZ5swtpGVNqx0YcoEtGT5KVfBtMVEVyusM/sQ0BidLTcOHkoXSHP5Pbt5+1Wg91p4gUf0gRG
        fwaLmZZhDXwAi8PAaNRarUqnYTVaNUvPkN+Y2LVDQRk5B5/D8zbe/t8nIWUxeaikMXbGyNZP
        pK7/8jJV15GVdRcW5O85GF2we46w/+rZuPs59PktTRN0SaWe7If917cMfz3K4czZKbGz2mXa
        Eucdo3+usHnmrjS5pzyj5lfkNMNY72BZ97vTj9pHS45RLuzZLtnrhm5vUn5zzroq4WUFzJlN
        fu+dumJKTcqBlgTlhg5aKmRxTAJmF7h/boWiDcgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvG7pppexBpOPK1s0L17PZjFlwwcm
        iw+bOCw6d15ltTh/fgO7xeVdc9gszizuZbdo63/A6MDhsXPWXXaPTas62Tz2z13D7tE3rYHR
        o2/LKkaP9Vuusnh83iQXwB7FZZOSmpNZllqkb5fAlXHz3XH2gq/GFdtfz2JpYDyr3MXIySEh
        YCLRfmw9cxcjF4eQwG5GiU9Xz7NCJGQkJrxYwgxhC0vcbznCClH0nFFiZcc9JpAEm4CfxN/m
        PSwgtohApMSSU60sIEXMAkeAiqa8Z4LomMYkcWPjL0aQKk4BA4lp/9aB2cICbhLf9s0FW8Ei
        oCJx+fgLNhCbV8BS4sfmxywQtqDEyZlPwGxmoFsbD3dD2fIS29/OgTpPQeLn02WsEFf4STRu
        +8IIUSMiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECI43Lc0djJeXxB9iFOBgVOLhnfH5RawQa2JZcWXuIUYJDmYlEd50vpexQrwpiZVV
        qUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTDGm/77WbiLf0nn48WN
        qpbZIfyxS/dmSs1JsGe/ycq8yLjP8DZPX7f99Lee+1fc93v9884evqcTPz/ku/q3hP8XW40p
        u+1xkVnfd6xkKdJwfvgsu+fFldstBmeiK3XZdk/fKLruEnd2eHcP59E/V+eaiUWXrQ+ULbIz
        db7O+MmrZoV80et1YT+UWIozEg21mIuKEwGn8fj/swIAAA==
X-CMS-MailID: 20191206014421epcas2p4ce83c029064c81d4f694ff9a4e3eadf6
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191205160249epcas2p3c1dcb24aba71f6b4264e76ebea36348c
References: <20191201075914.23512-1-kkoos00@naver.com>
        <20191201080314.GA3716559@kroah.com>
        <CAJKOXPet=RyJ3nrcOooHdN0GSO33Ce82-9L_X0oYC2MjN7nOig@mail.gmail.com>
        <CGME20191205160249epcas2p3c1dcb24aba71f6b4264e76ebea36348c@epcas2p3.samsung.com>
        <20191205160243.GA757198@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support module for Samsung serial driver,
I would like to split the file into 2 files.
Because it cannot be supported in one file both early console and
module driver
Thus some function need to change to EXPORT_SYMBOL to use in module
driver file.
I'm not pushed yet for module driver.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, December 6, 2019 1:03 AM
> To: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Hyunki Koo <kkoos00@naver.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> kkoos00@gmail.com; Shinbeom Choi <sbeom.choi@samsung.com>; Hyunki Koo
> <hyunki00.koo@samsung.com>
> Subject: Re: [PATCH] tty: serial: samsung: support driver modulization
> 
> On Thu, Dec 05, 2019 at 04:36:48PM +0100, Krzysztof Kozlowski wrote:
> > On Sun, 1 Dec 2019 at 09:05, Greg KH <gregkh@linuxfoundation.org>
> wrote:
> > >
> > > On Sun, Dec 01, 2019 at 04:59:14PM +0900, Hyunki Koo wrote:
> > > > From: Shinbeom Choi <sbeom.choi@samsung.com>
> > > >
> > > > This commit enables modulization of samsung uart driver.
> > > >
> > > > There was no way to make use of this driver in other module,
> > > > because uart functions were static.
> > > >
> > > > By exporting required functions, user can use this driver in
> other
> > > > module.
> > > >
> > > > Signed-off-by: Shinbeom Choi <sbeom.choi@samsung.com>
> > > > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > > > ---
> > > >  drivers/tty/serial/samsung.h     | 32 ++++++++++++
> > > >  drivers/tty/serial/samsung_tty.c | 85
> > > > +++++++++++++++-----------------
> > > >  2 files changed, 73 insertions(+), 44 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/samsung.h
> > > > b/drivers/tty/serial/samsung.h index f93022113f59..25be0962284d
> > > > 100644
> > > > --- a/drivers/tty/serial/samsung.h
> > > > +++ b/drivers/tty/serial/samsung.h
> > > > @@ -144,4 +144,36 @@ static inline void s3c24xx_clear_bit(struct
> uart_port *port, int idx,
> > > >       local_irq_restore(flags);
> > > >  }
> > > >
> > > > +#if defined(CONFIG_ARCH_EXYNOS)
> > > > +#define EXYNOS_COMMON_SERIAL_DRV_DATA
\
> > > > +     .info = &(struct s3c24xx_uart_info) {                   \
> > > > +             .name           = "Samsung Exynos UART",        \
> > > > +             .type           = PORT_S3C6400,                 \
> > > > +             .has_divslot    = 1,                            \
> > > > +             .rx_fifomask    = S5PV210_UFSTAT_RXMASK,        \
> > > > +             .rx_fifoshift   = S5PV210_UFSTAT_RXSHIFT,       \
> > > > +             .rx_fifofull    = S5PV210_UFSTAT_RXFULL,        \
> > > > +             .tx_fifofull    = S5PV210_UFSTAT_TXFULL,        \
> > > > +             .tx_fifomask    = S5PV210_UFSTAT_TXMASK,        \
> > > > +             .tx_fifoshift   = S5PV210_UFSTAT_TXSHIFT,       \
> > > > +             .def_clk_sel    = S3C2410_UCON_CLKSEL0,         \
> > > > +             .num_clks       = 1,                            \
> > > > +             .clksel_mask    = 0,                            \
> > > > +             .clksel_shift   = 0,                            \
> > > > +     },                                                      \
> > > > +     .def_cfg = &(struct s3c2410_uartcfg) {                  \
> > > > +             .ucon           = S5PV210_UCON_DEFAULT,         \
> > > > +             .ufcon          = S5PV210_UFCON_DEFAULT,        \
> > > > +             .has_fracval    = 1,                            \
> > > > +     }                                                       \
> > > > +
> > > > +#endif
> > > > +
> > > > +int s3c24xx_serial_get_ports(struct s3c24xx_uart_port
**ourport,
> > > > +int index); int s3c24xx_serial_init_port(struct
> s3c24xx_uart_port *ourport,
> > > > +                                 struct platform_device
> > > > +*platdev); int s3c24xx_serial_unregister_port(struct
> > > > +platform_device *dev); int s3c24xx_serial_suspend(struct device
> > > > +*dev); int s3c24xx_serial_resume(struct device *dev); int
> > > > +s3c24xx_serial_resume_noirq(struct device *dev);
> > > >  #endif
> > > > diff --git a/drivers/tty/serial/samsung_tty.c
> > > > b/drivers/tty/serial/samsung_tty.c
> > > > index 83fd51607741..15414ecd9008 100644
> > > > --- a/drivers/tty/serial/samsung_tty.c
> > > > +++ b/drivers/tty/serial/samsung_tty.c
> > > > @@ -1735,7 +1735,7 @@ static int
> s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
> > > >   * initialise a single serial port from the platform device
> given
> > > >   */
> > > >
> > > > -static int s3c24xx_serial_init_port(struct s3c24xx_uart_port
> > > > *ourport,
> > > > +int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> > > >                                   struct platform_device
*platdev)
> > > > {
> > > >       struct uart_port *port = &ourport->port; @@ -1842,12
> > > > +1842,24 @@ static int s3c24xx_serial_init_port(struct
> s3c24xx_uart_port *ourport,
> > > >       /* reset the fifos (and setup the uart) */
> > > >       s3c24xx_serial_resetport(port, cfg);
> > > >
> > > > +     if (!s3c24xx_uart_drv.state) {
> > > > +             ret = uart_register_driver(&s3c24xx_uart_drv);
> > > > +             if (ret < 0) {
> > > > +                     dev_err(port->dev, "Failed to register
Samsung
> UART driver\n");
> > > > +                     return ret;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     dbg("%s: adding port\n", __func__);
> > > > +     uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> > > > +
> > > >       return 0;
> > > >
> > > >  err:
> > > >       port->mapbase = 0;
> > > >       return ret;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(s3c24xx_serial_init_port);
> > >
> > > Why are you exporting all of these functions?  What other code
> uses
> > > them?  Why are you converting them all to global functions I don't
> > > see any other in-kernel callers, so why are those changes needed
> here?
> > >
> > > totally confused,
> >
> > I cannot find the original email from Hyunki on mailing lists
> (neither
> > LKML nor serial) so this was not even public till Greg replied.
> 
> I think it might have been sent in html format.
> 
> > Anyway, probably this is for new Android and some out-of-tree
> usage...
> > but it is wrong.
> 
> Making the driver be able to be built as a module is a good thing, no
> matter what project is causing the work to have happen.
> 
> And yes, it's Android :)
> 
> thanks,
> 
> greg k-h

