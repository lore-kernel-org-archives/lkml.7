Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F628C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6150C2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfB1H5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:57:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:52211 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfB1H5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:57:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 23:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,422,1544515200"; 
   d="scan'208";a="147254404"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 27 Feb 2019 23:56:57 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1gzGYq-00071s-2k; Thu, 28 Feb 2019 09:56:56 +0200
Date:   Thu, 28 Feb 2019 09:56:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jett Rink <jettrink@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
Message-ID: <20190228075656.GA9224@smile.fi.intel.com>
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CABXOdTdprS1OL534XQq8yHTFDzXdWWODq3VGrSEHYe2wmV5zfg@mail.gmail.com>
 <CAK+PMK67rWZarOV31n=yYbRMq3wo9vDyMTQ93PFZ7PRUMS66Ng@mail.gmail.com>
 <CABXOdTdbev2nKNjocqxOyPcGOU8zbWpQ7uALWZdEHL0CXkYDgA@mail.gmail.com>
 <CAK+PMK5U4YRtJNUbsQu3ARJFxwai7W=DjPfjuX_AZMFcUZ-c_A@mail.gmail.com>
 <39dc9be2-808e-4800-b4bb-605d5bf94e12@collabora.com>
 <CAK+PMK4ov8jJh7wZoTErikuztf=eOruG8xYt6umjt35f9EaGaA@mail.gmail.com>
 <3959820e-cf43-2370-7cea-7afd01b2933c@collabora.com>
 <CAMHSBOXF_PtSTpcnVcJE7bMRA85TCqZdJL3Md4Z_Cd4Djjkw1A@mail.gmail.com>
 <CAFqH_53CF2rOVt8G=amQXC2_0mNXZw2m8_kvkM2wMjx6GyWSaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_53CF2rOVt8G=amQXC2_0mNXZw2m8_kvkM2wMjx6GyWSaQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:05:35AM +0100, Enric Balletbo Serra wrote:
> Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dc., 27 de
> febr. 2019 a les 19:37:
> > On Wed, Feb 27, 2019 at 10:08 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > > On 27/2/19 16:13, Jett Rink wrote:

> > You're right, the cros_ names are based on what the EC provides.
> > cros_ec for generic EC, fp, tp for fingerprint, touch pad
> > respectively.
> > ish is for standalone sensor hub [it does not have to be Intel Sensor Hub].
> >
> 
> Thanks for the explanation. I didn't know that and I assumed the 'i'
> was for 'intel', maybe would be good call cros_ssh or cros_sh to avoid
> confusion?

i is for Integrated. There is no confusion.
It seems you misread what was written in [] above.

-- 
With Best Regards,
Andy Shevchenko


