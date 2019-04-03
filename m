Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF22BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6E72084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDCH2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:28:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:22772 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDCH2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:28:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 00:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,303,1549958400"; 
   d="scan'208";a="137159522"
Received: from rajeev-desktop.iind.intel.com (HELO intel.com) ([10.223.84.39])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2019 00:28:19 -0700
Date:   Wed, 3 Apr 2019 12:58:18 +0530
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     Jett Rink <jettrink@chromium.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Gwendal Grignou <gwendal@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform: chrome: Add ChromeOS EC ISHTP driver
Message-ID: <20190403072817.GA6944@intel.com>
References: <1554060310-18078-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAK+PMK4+KEyEZ-f86Fa1EVFz0UTrvGoL0ZzoNikgF-eaUuJfHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+PMK4+KEyEZ-f86Fa1EVFz0UTrvGoL0ZzoNikgF-eaUuJfHQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jett

On Tue, Apr 02, 2019 at 09:48:12AM -0600, Jett Rink wrote:
> On Sun, Mar 31, 2019 at 1:25 PM Rushikesh S Kadam
> <rushikesh.s.kadam@intel.com> wrote:

> > +
> > +/*
> > + * The Read-Write Semaphore is used to prevent message TX or RX while
> > + * the ishtp client is being initialized or undergoing reset.
> > + *
> > + * The readers are the kernel function calls responsibile for IA->ISH
> nit: s/responsibile/responsible

Thanks

> > +/**
> > + * ish_send() - Send message from host to firmware
> > + * @client_data:       Client data instance
> > + * @out_msg:           Message buffer to be sent to firmware
> > + * @out_size:          Size of out going message
> > + * @in_msg:            Message buffer where the incoming data copied.
> > + *                     This buffer is allocated by calling
> > + * @in_size:           Max size of incoming message
> > + *
> > + * Return: Number of bytes copied in the in_msg on success, negative
> > + * error code on failure.
> > + */
> > +static int ish_send(struct ishtp_cl_data *client_data,
> > +                   u8 *out_msg, size_t out_size,
> > +                   u8 *in_msg, size_t in_size)
> > +{
> > +       int rv;
> > +       struct header *out_hdr = (struct header *)out_msg;
> > +       struct ishtp_cl *cros_ish_cl = client_data->cros_ish_cl;
> > +
> > +       dev_dbg(cl_data_to_dev(client_data),
> > +               "%s: channel=%02u status=%02u\n",
> > +               __func__, out_hdr->channel, out_hdr->status);
> > +
> > +       /* Setup for in-coming response */
> nit:s/in-coming/incoming/

Thanks

> > +/**
> > + * ish_event_cb() - bus driver callback for incoming
> > + *                     message
> > + * @cl_device:         ISHTP client device for which this message is
> > + *                     targeted.
> > + *
> > + * Remove the packet from the list and process the message by calling
> > + * process_recv.
> > + */
> > +static void ish_event_cb(struct ishtp_cl_device *cl_device)
> > +{
> > +       struct ishtp_cl_rb *rb_in_proc;
> > +       struct ishtp_cl_data *client_data;
> > +       struct ishtp_cl *cros_ish_cl = ishtp_get_drvdata(cl_device);
> > +
> > +       client_data = ishtp_get_client_data(cros_ish_cl);
> > +
> > +       while ((rb_in_proc = ishtp_cl_rx_get_rb(cros_ish_cl)) != NULL) {
> > +               /* Decide what to do with received data */
> > +               process_recv(cros_ish_cl, rb_in_proc);
> > +       }
> > +}
> > +
> > +/**
> > + * cros_ish_init() - Init function for ISHTP client
> > + * @cros_ish_cl:       ISHTP client instance
> > + * @reset:             true if called for init after reset
> > + *
> > + * This function complete the initializtion of the client.
> > + *
> > + * Return: 0 on success, non zero on error
> > + */
> > +static int cros_ish_init(struct ishtp_cl *cros_ish_cl, int reset)
> > +{
> > +       int rv;
> > +       struct ishtp_device *dev;
> > +       struct ishtp_fw_client *fw_client;
> > +       struct ishtp_cl_data *client_data =
> > +               ishtp_get_client_data(cros_ish_cl);
> > +
> > +       dev_dbg(cl_data_to_dev(client_data), "reset flag: %d\n", reset);
> Why are we passing in the reset flag here, we are only using it for a
> debug message; it
> doesn't seem worth passing reset as a parameter.

Yes, will drop the reset flag.

> 
> > +late_initcall(cros_ec_ishtp_mod_init);
> > +module_exit(cros_ec_ishtp_mod_exit);
> > +
> > +MODULE_DESCRIPTION("ChromeOS EC ISHTP Client Driver");
> > +MODULE_AUTHOR("Rushikesh S Kadam <rushikesh.s.kadam@intel.com>");
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("ishtp:*");
> > --
> > 1.9.1
> >
> 
> Besides the minor comments, this looks good to me, and I will add
> review and tested tags on subsequent patch.

I'll send v2 shortly

Regards
Rushikesh

-- 
