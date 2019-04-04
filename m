Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0EE21901
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368907;
	bh=3XRiMYn4ZOklETmsrshP6grQqW3HCKuTMq4lWp+ndDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r4oHH9/tjOHS/OmyjN1alg/swvBza/PhtJlgwhY8zNH6voMlMM5C9PdbwVePQCvzU
	 VP3mdU9Y+PYHOwgNsoBQUlX25nxjCtcS89G2XuGb9UFYP148ngi3dQRe2ncaB92O0+
	 8IlxTqGmMOctdaGZhL2PjGKORWF4szjFm7z7ESFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfDDJIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732442AbfDDJIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3670E2186A;
        Thu,  4 Apr 2019 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368900;
        bh=3XRiMYn4ZOklETmsrshP6grQqW3HCKuTMq4lWp+ndDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQDo2SMj+sK76TVquy/U+4muAQFczkhKQFIxd0CrmEnMh9dfuKiwmt9LfoERBrhfh
         rV9VI5eh7EUbr0bgTTlu1I+W/hBnIj00pdYYSrCH+mf1QzzVLD2dYx0U2G8C+Detb8
         eCJflsFO8/yiB1KBfc2xzQvguPNVyuXJBKsdZRiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 023/246] iio: adc: fix warning in Qualcomm PM8xxx HK/XOADC driver
Date:   Thu,  4 Apr 2019 10:45:23 +0200
Message-Id: <20190404084619.944233552@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e0f0ae838a25464179d37f355d763f9ec139fc15 ]

The pm8xxx_get_channel() implementation is unclear, and causes gcc to
suddenly generate odd warnings.  The trigger for the warning (at least
for me) was the entirely unrelated commit 79a4e91d1bb2 ("device.h: Add
__cold to dev_<level> logging functions"), which apparently changes gcc
code generation in the caller function enough to cause this:

  drivers/iio/adc/qcom-pm8xxx-xoadc.c: In function ‘pm8xxx_xoadc_probe’:
  drivers/iio/adc/qcom-pm8xxx-xoadc.c:633:8: warning: ‘ch’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    ret = pm8xxx_read_channel_rsv(adc, ch, AMUX_RSV4,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             &read_nomux_rsv4, true);
             ~~~~~~~~~~~~~~~~~~~~~~~
  drivers/iio/adc/qcom-pm8xxx-xoadc.c:426:27: note: ‘ch’ was declared here
    struct pm8xxx_chan_info *ch;
                             ^~

because gcc for some reason then isn't able to see that the termination
condition for the "for( )" loop in that function is also the condition
for returning NULL.

So it's not _actually_ uninitialized, but the function is admittedly
just unnecessarily oddly written.

Simplify and clarify the function, making gcc also see that it always
returns a valid initialized value.

Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index c30c002f1fef..4735f8a1ca9d 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -423,18 +423,14 @@ static irqreturn_t pm8xxx_eoc_irq(int irq, void *d)
 static struct pm8xxx_chan_info *
 pm8xxx_get_channel(struct pm8xxx_xoadc *adc, u8 chan)
 {
-	struct pm8xxx_chan_info *ch;
 	int i;
 
 	for (i = 0; i < adc->nchans; i++) {
-		ch = &adc->chans[i];
+		struct pm8xxx_chan_info *ch = &adc->chans[i];
 		if (ch->hwchan->amux_channel == chan)
-			break;
+			return ch;
 	}
-	if (i == adc->nchans)
-		return NULL;
-
-	return ch;
+	return NULL;
 }
 
 static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
-- 
2.19.1



