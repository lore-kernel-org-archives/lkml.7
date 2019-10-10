Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEBDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3569D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfJJLQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:16:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:49916 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfJJLQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:16:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 04:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="207171922"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 10 Oct 2019 04:16:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Oct 2019 14:16:20 +0300
Date:   Thu, 10 Oct 2019 14:16:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/2] extcon: axp288: Move to swnodes
Message-ID: <20191010111620.GB4981@kuha.fi.intel.com>
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
 <8120fbf2-08d3-6ee2-21bf-458a4e12b29c@redhat.com>
 <20191008140159.GC12909@kuha.fi.intel.com>
 <20191010083110.GA4981@kuha.fi.intel.com>
 <7730d466-53bc-c14a-120f-dcb91de1e973@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7730d466-53bc-c14a-120f-dcb91de1e973@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 11:32:23AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10-10-2019 10:31, Heikki Krogerus wrote:
> > On Tue, Oct 08, 2019 at 05:02:04PM +0300, Heikki Krogerus wrote:
> > > On Tue, Oct 08, 2019 at 03:59:23PM +0200, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 08-10-2019 14:25, Heikki Krogerus wrote:
> > > > > Hi Hans,
> > > > > 
> > > > > Fixed the compiler warning in this version. No other changes.
> > > > > 
> > > > > The original cover letter:
> > > > > 
> > > > > That AXP288 extcon driver is the last that uses build-in connection
> > > > > description. I'm replacing it with a code that finds the role mux
> > > > > software node instead.
> > > > > 
> > > > > I'm proposing also here a little helper
> > > > > usb_role_switch_find_by_fwnode() that uses
> > > > > class_find_device_by_fwnode() to find the role switches.
> > > > 
> > > > Both patches look good to me and I can confirm that things still
> > > > work as they should on a CHT device with an AXP288 PMIC, so for both:
> > > > 
> > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > > 
> > > > Regards,
> > > > 
> > > > Hans
> > > > 
> > > > p.s.
> > > > 
> > > > I guess this means we can remove the build-in connection (
> > > > device_connection_add / remove) stuff now?
> > > 
> > > Yes. I'll prepare separate patches for that.
> > 
> > Actually, maybe it would make sense to just remove it in this series.
> > I'm attaching a patch that remove struct device_connection completely.
> > Can you check if it makes sense to you?
> 
> This bit seems broken:
> 
>  static void *
>  fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>                           void *data, devcon_match_fn_t match)
>  {
> -       struct device_connection con = { .id = con_id };
>         struct fwnode_handle *ep;
>         void *ret;
> 
>         fwnode_graph_for_each_endpoint(fwnode, ep) {
> -               con.fwnode = fwnode_graph_get_remote_port_parent(ep);
> -               if (!fwnode_device_is_available(con.fwnode))
> +               fwnode = fwnode_graph_get_remote_port_parent(ep);
> 
> You are no replacing the passed in fwnode with the fwnode for the
> remote_port_parent and then the next time through the loop you will
> look at the wrong fwnode as the fwnode argument to
> fwnode_graph_for_each_endpoint() gets evaluated multiple times:
> 
> #define fwnode_graph_for_each_endpoint(fwnode, child)                   \
>         for (child = NULL;                                              \
>              (child = fwnode_graph_get_next_endpoint(fwnode, child)); )
> 
> ###
> 
> And there is a similar problem here, where you again use the fwmode
> argument also as local variable in a loop where the function
> argument should be evaluated more then once:
> 
>  fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>                     void *data, devcon_match_fn_t match)
>  {
> -       struct device_connection con = { };
>         void *ret;
>         int i;
> 
>         for (i = 0; ; i++) {
> -               con.fwnode = fwnode_find_reference(fwnode, con_id, i);
> -               if (IS_ERR(con.fwnode))
> +               fwnode = fwnode_find_reference(fwnode, con_id, i);
> 
> ###
> 
> And it seems that this bit where you introduce -EPROBE_DEFER is an unrelated
> behavior change? :
> 
> +static void *generic_match(struct fwnode_handle *fwnode, const char *id,
> +                          void *data)
>  {
>         struct bus_type *bus;
>         struct device *dev;
> +       void *ret = NULL;
> 
>         for (bus = generic_match_buses[0]; bus; bus++) {
> -               dev = bus_find_device_by_fwnode(bus, con->fwnode);
> -               if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
> -                       return dev;
> +               dev = bus_find_device_by_fwnode(bus, fwnode);
> +               if (dev) {
> +                       if (!strncmp(dev_name(dev), id, strlen(id)))
> +                               return dev;
> +                       ret = ERR_PTR(-EPROBE_DEFER);
> +               }
> 
> 
> Note that the old generic_match code had:
> 
> -       if (con->fwnode)
> -               return device_connection_fwnode_match(con);
> 
> Which will simply always return either the dev or NULL, so as said this
> is a behavior change AFAICT.
> 
> I've been trying to figure out what you are trying to do here and
> I found a troublesome path through the old code:
> 
> 1. device_connection_find() gets called on a device with a fwnode
> 2. device_connection_find() calls device_connection_find_match()
> 3. device_connection_find_match() calls fwnode_connection_find_match()
> 4. fwnode_connection_find_match() calls fwnode_graph_devcon_match() this returns NULL
> 5. fwnode_connection_find_match() calls fwnode_devcon_match()
> 6. fwnode_devcon_match() creates a struct device_connection with just fwnode set, the rest is 0/NULL
> 7. fwnode_devcon_match() calls generic_match() with this struct
> 8. generic_match() calls device_connection_fwnode_match() because con->fwnode is set
> 9. device_connection_fwnode_match() does the following if a device is found:
>    if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
>        return dev;
>    but con->id is NULL here, so we have a NULL pointer deref here!
> 
> We are currently not hitting this path because there are no callers of
> device_connection_find() all devcon users currently use device_connection_find_match()
> 
> Note I believe the code after your patch still has this problem. Also doing
> the strcmp on the dev_name seems wrong? At least for the above code path, where
> fwnode_devcon_match() has already used / consumed the id.
> 
> So at a minimum we need to add a id == NULL check to generic_match (*), but
> Since there are no users and the strcmp to to dev_name is weird, I believe that
> it would be better to just remove device_connection_find() (and generic_match, etc.) ?

Yes! That makes sense to me. That function really serves no purpose.

> This could be a preparation patch for the patch you attached, this would simplify
> this patch a bit.
> 
> ###
> 
> If we end up with something like your suggested patch I think it might be good to
> do a follow up where device_connection_find_match callers simply call
> fwnode_connection_find_match directly and we remove device_connection_find_match ?
> Or maybe turn it into a static inline function?

Sure. I think it would make sense to move that
fwnode_connection_find_match() function under drivers/base/property.c
at the same time, and get rid of this devcon.c file completely.

But before that, I would like to do a change to the software node
support, if that's OK. I have to now add support for the "device
graph" to the software nodes in any case (not because of this).

I'm really not a fan of that "device graph" thing (I think it's over
engineered) but if the software nodes support it, I think we probable
need to always use it to describe these connections (because that's
what DT uses). That would leave us with only one method of describing
these connections (the device graph) compared to the three we have
now (built-in, device graph and the "references").

In any case, do we leave this series as it is now, or should I add two
patches to it - one that just removes device_connection_add/remove
functions without any other changes, and another patch that removes
that device_connection_find() function (together with generic_match
etc.)?

thanks,

-- 
heikki
