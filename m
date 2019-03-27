Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17697C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5EC2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710256;
	bh=uXnjpxAhJ0NJevHTQ+WLhA3oWQsyO/F5W2zTP3iwFJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8QtrExeUAbbMsY/pilAqzQzaq8FoBRrICzJejjcH6+z7Oq0F37ZLxBK4Csn5jdMy
	 VM9IUsg/M08+LClpSnDUTOLzmM1Y3ccmDVUWCZiOYu+SVgth7vnDO+dRMPz2pHxVmC
	 c1bIiDQzbsEHCjnrRcJ6HtTIUJksGIV/lnpIJmmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfC0SKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfC0SKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715792177E;
        Wed, 27 Mar 2019 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710251;
        bh=uXnjpxAhJ0NJevHTQ+WLhA3oWQsyO/F5W2zTP3iwFJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMJnXPy0fVcYTvrH3DCuhlczdxlgqAyjnvpriz+TOwQmNoi58Anv1Lt01Et05OrDg
         HWVsVDTENo4UoOsmGUXAEiHds9r2aQaKzvQC5CenwrrBZVu0L0iTYbo7bmuAXhlNmY
         m4w5knp2fiqYBXb8Cges5dwxOAF4PY2/Ty757vdQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 018/192] iio: adc: fix warning in Qualcomm PM8xxx HK/XOADC driver
Date:   Wed, 27 Mar 2019 14:07:30 -0400
Message-Id: <20190327181025.13507-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

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
index b093ecddf1a8..54db848f0bcd 100644
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

