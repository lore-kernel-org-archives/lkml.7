Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DF421917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrjahOG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfCUQv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:51:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37825 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfCUQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:51:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id c1so16731260qkk.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAQxKR0K3RuabRCrD0gTO/S+MR26po3K5OJrC0fsqPk=;
        b=LrjahOG1nqV6QFODDStbLc4vSBtPMpwbPN0yBrpiOKlyOKjsWT7/YtlIu8NzEtntY8
         L7HnRubAxD9dvhAga6jDSLruC5PIkpRn9bTS2zSCLlihHY9pmPjLXhEEL7EoBYDuFz7h
         tz9UtndNXmoQwSPju3tO3WmOhpIO/IdsFIPK1Fi1Zom4OYzi+ukskvkS6U0Jmns+/yoE
         JOCkAPD3iDCJo2X+izA7+Lwu6dCA8yKBrYZHOlpFQk8fXCLRIYXNfMtGt83Y+AITcQmh
         BUXE+WcQWeMnGdZS6//oQ/9tj+/kP0NDe1SYZWpzJYoSp4fBYfY3fTDfV6Tojb6r2fFs
         kPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAQxKR0K3RuabRCrD0gTO/S+MR26po3K5OJrC0fsqPk=;
        b=MIIDNEby3xQ6ZXKR7wfujKRKdW47K1gDGdYZuEVJiMMSqHKzYqGoV0FfCW+3z0Zsdf
         /mnWWiBD7E49FMWukm+vlnAJ0Pv3/j8RHbj6AOuIG0BsOnEcaCTFExBP39HyCt1A+Okf
         EiZ56stA+sYzUdViOOTL1US3TCC+8h7ujzTU/PP3yZpOkQETFDmjXuSpRxiEqI8H3jjO
         tkM6QuJ1V+KiCTnO8b5AwmPGgEffa7qc0q516jTv9izfCMgo7AekKOpRBtFTxa+aPYLJ
         mkghc9FFWcMol7qy2ZOBdyz6+cqoywn4b+tSQmiB5AD+HqRc5d4AG6kgdz2+QkNVTMdy
         dlRw==
X-Gm-Message-State: APjAAAWxfgYvaZZCOEtpsLfikOT8cwlR0AhrtoihiCB5E+nm4/SFBK8V
        4xtYfG6OyVB0vlZBrAmln0v/RK5KDZ6I7r0OC/4gfA==
X-Google-Smtp-Source: APXvYqw7PINBa+9cQluNA5Hf+bUlu3rDXJjgihB0Nz2itQkSqDdatNKz6TGp9wqPJoEBJxMXFvnqPHINTPzzvCeUzRA=
X-Received: by 2002:a37:a4d1:: with SMTP id n200mr3601080qke.62.1553187082215;
 Thu, 21 Mar 2019 09:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190319064050.149212-1-kyletso@google.com> <20190319173802.GA31323@roeck-us.net>
In-Reply-To: <20190319173802.GA31323@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 22 Mar 2019 00:51:09 +0800
Message-ID: <CAGZ6i=0qeF1YU9N3pnKjejsKY76bY_sfqbwN83LWMRMr82k=nA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: collision avoidance
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:38 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> > This patch provides the implementation of Collision Avoidance introduced
> > in PD3.0. The start of each Atomic Message Sequence (AMS) initiated by
> > the port will be denied if the current AMS is not interruptible. The
> > Source port will set the CC to SinkTxNG if it is going to initiate an
> > AMS, and SinkTxOk otherwise. Meanwhile, any AMS initiated by a Sink port
> > will be denied in TCPM if the port partner (Source) sets SinkTxNG except
> > for HARD_RESET and SOFT_RESET.
> >
>
> That wil require a detailed review; I am quite concerned that the added
> complexity may have negative impact on existing (and possibly less than
> perfect partners.
>
> Coupld of initial comments below.
>
> Guenter
>
I tried not to affect any existing implementation here if the port
partner is PD2.0.
If the port partner supports PD3.0, it should be compliant with
Collision Avoidance.

> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 539 ++++++++++++++++++++++++++++++----
> >  include/linux/usb/pd.h        |   1 +
> >  include/linux/usb/tcpm.h      |   4 +
> >  3 files changed, 484 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 0f62db091d8d..312008cdc7d3 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -71,6 +71,8 @@
> >       S(SNK_HARD_RESET_SINK_ON),              \
> >                                               \
> >       S(SOFT_RESET),                          \
> > +     S(SRC_SOFT_RESET_WAIT_SNK_TX),          \
> > +     S(SNK_SOFT_RESET),                      \
> >       S(SOFT_RESET_SEND),                     \
> >                                               \
> >       S(DR_SWAP_ACCEPT),                      \
> > @@ -124,7 +126,45 @@
> >                                               \
> >       S(ERROR_RECOVERY),                      \
> >       S(PORT_RESET),                          \
> > -     S(PORT_RESET_WAIT_OFF)
> > +     S(PORT_RESET_WAIT_OFF),                 \
> > +                                             \
> > +     S(AMS_START)
> > +
> > +#define FOREACH_AMS(S)                               \
> > +     S(NONE_AMS),                            \
> > +     S(POWER_NEGOTIATION),                   \
> > +     S(GOTOMIN),                             \
> > +     S(SOFT_RESET_AMS),                      \
> > +     S(HARD_RESET),                          \
> > +     S(CABLE_RESET),                         \
> > +     S(GET_SOURCE_CAPABILITIES),             \
> > +     S(GET_SINK_CAPABILITIES),               \
> > +     S(POWER_ROLE_SWAP),                     \
> > +     S(FAST_ROLE_SWAP),                      \
> > +     S(DATA_ROLE_SWAP),                      \
> > +     S(VCONN_SWAP),                          \
> > +     S(SOURCE_ALERT),                        \
> > +     S(GETTING_SOURCE_EXTENDED_CAPABILITIES),\
> > +     S(GETTING_SOURCE_SINK_STATUS),          \
> > +     S(GETTING_BATTERY_CAPABILITIES),        \
> > +     S(GETTING_BATTERY_STATUS),              \
> > +     S(GETTING_MANUFACTURER_INFORMATION),    \
> > +     S(SECURITY),                            \
> > +     S(FIRMWARE_UPDATE),                     \
> > +     S(DISCOVER_IDENTITY),                   \
> > +     S(SOURCE_STARTUP_CABLE_PLUG_DISCOVER_IDENTITY), \
> > +     S(DISCOVER_SVIDS),                      \
> > +     S(DISCOVER_MODES),                      \
> > +     S(DFP_TO_UFP_ENTER_MODE),               \
> > +     S(DFP_TO_UFP_EXIT_MODE),                \
> > +     S(DFP_TO_CABLE_PLUG_ENTER_MODE),        \
> > +     S(DFP_TO_CABLE_PLUG_EXIT_MODE),         \
> > +     S(ATTENTION),                           \
> > +     S(BIST),                                \
> > +     S(UNSTRUCTURED_VDMS),                   \
> > +     S(STRUCTURED_VDMS),                     \
> > +     S(COUNTRY_INFO),                        \
> > +     S(COUNTRY_CODES)
> >
> >  #define GENERATE_ENUM(e)     e
> >  #define GENERATE_STRING(s)   #s
> > @@ -137,6 +177,14 @@ static const char * const tcpm_states[] = {
> >       FOREACH_STATE(GENERATE_STRING)
> >  };
> >
> > +enum tcpm_ams {
> > +     FOREACH_AMS(GENERATE_ENUM)
> > +};
> > +
> > +static const char * const tcpm_ams_str[] = {
> > +     FOREACH_AMS(GENERATE_STRING)
> > +};
> > +
> >  enum vdm_states {
> >       VDM_STATE_ERR_BUSY = -3,
> >       VDM_STATE_ERR_SEND = -2,
> > @@ -146,6 +194,7 @@ enum vdm_states {
> >       VDM_STATE_READY = 1,
> >       VDM_STATE_BUSY = 2,
> >       VDM_STATE_WAIT_RSP_BUSY = 3,
> > +     VDM_STATE_SEND_MESSAGE = 4,
> >  };
> >
> >  enum pd_msg_request {
> > @@ -320,6 +369,11 @@ struct tcpm_port {
> >       /* port belongs to a self powered device */
> >       bool self_powered;
> >
> > +     /* Collision Avoidance and Atomic Message Sequence */
> > +     enum tcpm_state upcoming_state;
> > +     enum tcpm_ams ams;
> > +     bool in_ams;
> > +
> >  #ifdef CONFIG_DEBUG_FS
> >       struct dentry *dentry;
> >       struct mutex logbuffer_lock;    /* log buffer access lock */
> > @@ -371,6 +425,16 @@ struct pd_rx_event {
> >       ((port)->try_src_count == 0 && (port)->try_role == TYPEC_SOURCE && \
> >       (port)->port_type == TYPEC_PORT_DRP)
> >
> > +#define tcpm_sink_tx_ok(port) \
> > +     (tcpm_port_is_sink(port) && \
> > +     ((port)->cc1 == TYPEC_CC_RP_3_0 || (port)->cc2 == TYPEC_CC_RP_3_0))
> > +
> > +#define tcpm_switch_state(port, state, delay) \
> > +     do { \
> > +             (port)->upcoming_state = INVALID_STATE; \
> > +             tcpm_set_state(port, state, delay); \
> > +     } while (0)
> > +
> >  static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
> >  {
> >       if (port->port_type == TYPEC_PORT_DRP) {
> > @@ -600,6 +664,9 @@ static void tcpm_debugfs_exit(const struct tcpm_port *port) { }
> >
> >  #endif
> >
> > +static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams,
> > +                       bool start);
> > +
>
> Does this have to be a forward declaration ?
>
tcpm_pd_transmit() calls tcpm_ams_start() and tcpm_ams_start() calls
tcpm_pd_transmit()

> >  static int tcpm_pd_transmit(struct tcpm_port *port,
> >                           enum tcpm_transmit_type type,
> >                           const struct pd_message *msg)
> > @@ -627,13 +694,30 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
> >       switch (port->tx_status) {
> >       case TCPC_TX_SUCCESS:
> >               port->message_id = (port->message_id + 1) & PD_HEADER_ID_MASK;
> > -             return 0;
> > +             /*
> > +              * USB PD rev 3.0, 8.3.2.1.3:
> > +              * "... Note that every AMS is Interruptible until the first
> > +              * Message in the sequence has been successfully sent (GoodCRC
> > +              * Message received)."
> > +              */
> > +             if ((port->negotiated_rev >= PD_REV30) &&
> > +                 (port->ams != NONE_AMS))
>
> Excessive ( )
>
will fix this in the next version

> > +                     port->in_ams = true;
> > +             break;
> >       case TCPC_TX_DISCARDED:
> > -             return -EAGAIN;
> > +             ret = -EAGAIN;
> > +             break;
> >       case TCPC_TX_FAILED:
> >       default:
> > -             return -EIO;
> > +             ret = -EIO;
> > +             break;
> >       }
> > +
> > +     /* Some AMS don't expect responses. Finish them here. */
> > +     if (port->ams == ATTENTION || port->ams == SOURCE_ALERT)
> > +             tcpm_ams_start(port, port->ams, false);
>
> Calling tcpm_ams_start() when the actual action is finish, and even more
> so when the code itself has almost no overlap, doesn't make sense to me.
> This should be a call to a separate function. More on that below.
>
If the AMS is initiated by Source, the Source should set CC to SinkTxNG first
, wait for tSinkTx, and then set it back to SinkTxOk after the Source gets
GoodCRC (or the AMS fails).

> > +
> > +     return ret;
> >  }
> >
> >  void tcpm_pd_transmit_complete(struct tcpm_port *port,
> > @@ -883,17 +967,20 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
> >                          unsigned int delay_ms)
> >  {
> >       if (delay_ms) {
> > -             tcpm_log(port, "pending state change %s -> %s @ %u ms",
> > -                      tcpm_states[port->state], tcpm_states[state],
> > -                      delay_ms);
> > +             tcpm_log(port, "pending state change %s -> %s @ %u ms [%s]",
> > +                      tcpm_states[port->state], tcpm_states[state], delay_ms,
> > +                      port->negotiated_rev >= PD_REV30 ?
> > +                      tcpm_ams_str[port->ams] : "");
>
> "[%s]" results in [] for PD 2.0. This is undesirable and confusing.
> [] should be part of the conditional string. Also, The potential text
> in [] doesn't have an explanation.
>
>                 port->negotiated_rev >= PD_REV30 ?
>                         tcpm_ams_str[port->ams] : "");
>
> is repeated several times and should be a separate function or macro.
>
will fix these in the next version

> >               port->delayed_state = state;
> >               mod_delayed_work(port->wq, &port->state_machine,
> >                                msecs_to_jiffies(delay_ms));
> >               port->delayed_runtime = jiffies + msecs_to_jiffies(delay_ms);
> >               port->delay_ms = delay_ms;
> >       } else {
> > -             tcpm_log(port, "state change %s -> %s",
> > -                      tcpm_states[port->state], tcpm_states[state]);
> > +             tcpm_log(port, "state change %s -> %s [%s]",
> > +                      tcpm_states[port->state], tcpm_states[state],
> > +                      port->negotiated_rev >= PD_REV30 ?
> > +                      tcpm_ams_str[port->ams] : "");
> >               port->delayed_state = INVALID_STATE;
> >               port->prev_state = port->state;
> >               port->state = state;
> > @@ -915,10 +1002,12 @@ static void tcpm_set_state_cond(struct tcpm_port *port, enum tcpm_state state,
> >               tcpm_set_state(port, state, delay_ms);
> >       else
> >               tcpm_log(port,
> > -                      "skipped %sstate change %s -> %s [%u ms], context state %s",
> > +                      "skipped %sstate change %s -> %s [%u ms], context state %s [%s]",
> >                        delay_ms ? "delayed " : "",
> >                        tcpm_states[port->state], tcpm_states[state],
> > -                      delay_ms, tcpm_states[port->enter_state]);
> > +                      delay_ms, tcpm_states[port->enter_state],
> > +                      port->negotiated_rev >= PD_REV30 ?
> > +                      tcpm_ams_str[port->ams] : "");
> >  }
> >
> >  static void tcpm_queue_message(struct tcpm_port *port,
> > @@ -928,6 +1017,160 @@ static void tcpm_queue_message(struct tcpm_port *port,
> >       mod_delayed_work(port->wq, &port->state_machine, 0);
> >  }
> >
> > +static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
> > +{
> > +     tcpm_log(port, "cc:=%d", cc);
> > +     port->cc_req = cc;
> > +     port->tcpc->set_cc(port->tcpc, cc);
> > +}
> > +
> > +static bool tcpm_vdm_ams(struct tcpm_port *port)
> > +{
> > +     switch (port->ams) {
> > +     case DISCOVER_IDENTITY:
> > +     case SOURCE_STARTUP_CABLE_PLUG_DISCOVER_IDENTITY:
> > +     case DISCOVER_SVIDS:
> > +     case DISCOVER_MODES:
> > +     case DFP_TO_UFP_ENTER_MODE:
> > +     case DFP_TO_UFP_EXIT_MODE:
> > +     case DFP_TO_CABLE_PLUG_ENTER_MODE:
> > +     case DFP_TO_CABLE_PLUG_EXIT_MODE:
> > +     case ATTENTION:
> > +     case UNSTRUCTURED_VDMS:
> > +     case STRUCTURED_VDMS:
> > +             break;
> > +     default:
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static bool tcpm_ams_interruptible(struct tcpm_port *port)
> > +{
> > +     switch (port->ams) {
> > +     /* Interruptible AMS */
> > +     case NONE_AMS:
> > +     case SECURITY:
> > +     case FIRMWARE_UPDATE:
> > +     case DISCOVER_IDENTITY:
> > +     case SOURCE_STARTUP_CABLE_PLUG_DISCOVER_IDENTITY:
> > +     case DISCOVER_SVIDS:
> > +     case DISCOVER_MODES:
> > +     case DFP_TO_UFP_ENTER_MODE:
> > +     case DFP_TO_UFP_EXIT_MODE:
> > +     case DFP_TO_CABLE_PLUG_ENTER_MODE:
> > +     case DFP_TO_CABLE_PLUG_EXIT_MODE:
> > +     case UNSTRUCTURED_VDMS:
> > +     case STRUCTURED_VDMS:
> > +     case COUNTRY_INFO:
> > +     case COUNTRY_CODES:
> > +             break;
> > +     /* Non-Interruptible AMS */
> > +     default:
> > +             if (port->in_ams)
> > +                     return false;
> > +             break;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams, bool start)
> > +{
> > +     int ret = 0;
> > +
> > +     if (port->negotiated_rev < PD_REV30) {
> > +             port->upcoming_state = INVALID_STATE;
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (!start)
> > +             goto ams_finish;
>
> This is just confusing. Please handle "finish" in a separate function.
> Checking the PD version is not enough overlap to warrant this kind of code.
>
> This is even more true since every call of tcpm_ams_start(port, ams, false)
> actually has port->ams as second parameter. This makes the code even more
> complex and more difficult to understand than it already is.
>
will fix this in the next version

> > +
> > +     tcpm_log(port, "AMS: %s start", tcpm_ams_str[ams]);
> > +
> > +     if (!tcpm_ams_interruptible(port) && ams != HARD_RESET) {
> > +             port->upcoming_state = INVALID_STATE;
> > +             tcpm_log(port, "AMS: %s not interruptible, aborting",
> > +                      tcpm_ams_str[port->ams]);
> > +             return -EAGAIN;
> > +     }
> > +
> > +     if (port->pwr_role == TYPEC_SOURCE) {
> > +             enum typec_cc_status cc_req;
> > +
> > +             port->ams = ams;
> > +
> > +             if (ams == HARD_RESET) {
> > +                     tcpm_set_cc(port, tcpm_rp_cc(port));
> > +                     tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
> > +                     tcpm_set_state(port, HARD_RESET_START, 0);
> > +                     return 0;
> > +             } else if (ams == SOFT_RESET_AMS) {
> > +                     if (!port->explicit_contract) {
> > +                             port->upcoming_state = INVALID_STATE;
> > +                             tcpm_set_cc(port, tcpm_rp_cc(port));
> > +                             return 0;
> > +                     }
> > +             } else if (tcpm_vdm_ams(port)) {
> > +                     /* tSinkTx is enforced in vdm_run_state_machine */
> > +                     tcpm_set_cc(port, SINK_TX_NG);
> > +                     return 0;
> > +             }
> > +
> > +             cc_req = port->cc_req;
> > +             tcpm_set_cc(port, SINK_TX_NG);
> > +             if (port->state == SRC_READY ||
> > +                 port->state == SRC_STARTUP ||
> > +                 port->state == SRC_SOFT_RESET_WAIT_SNK_TX ||
> > +                 port->state == SOFT_RESET ||
> > +                 port->state == SOFT_RESET_SEND)
> > +                     tcpm_set_state(port, AMS_START, cc_req == SINK_TX_OK ?
> > +                                    PD_T_SINK_TX : 0);
> > +             else
> > +                     tcpm_set_state(port, SRC_READY, cc_req == SINK_TX_OK ?
> > +                                    PD_T_SINK_TX : 0);
> > +     } else {
> > +             if (!tcpm_sink_tx_ok(port) &&
> > +                 ams != SOFT_RESET_AMS &&
> > +                 ams != HARD_RESET) {
> > +                     port->upcoming_state = INVALID_STATE;
> > +                     tcpm_log(port, "Sink TX No Go");
> > +                     return -EAGAIN;
> > +             }
> > +
> > +             port->ams = ams;
> > +
> > +             if (ams == HARD_RESET) {
> > +                     tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
> > +                     tcpm_set_state(port, HARD_RESET_START, 0);
> > +                     return 0;
> > +             } else if (tcpm_vdm_ams(port)) {
> > +                     return 0;
> > +             }
> > +
> > +             if (port->state == SNK_READY ||
> > +                 port->state == SNK_SOFT_RESET)
> > +                     tcpm_set_state(port, AMS_START, 0);
> > +             else
> > +                     tcpm_set_state(port, SNK_READY, 0);
> > +     }
> > +
> > +     return ret;
> > +
> > +ams_finish:
> > +     tcpm_log(port, "AMS: %s finished", tcpm_ams_str[ams]);
> > +
> > +     if (port->pwr_role == TYPEC_SOURCE)
> > +             tcpm_set_cc(port, SINK_TX_OK);
> > +
> > +     port->in_ams = false;
> > +     port->ams = NONE_AMS;
> > +
> > +     return ret;
> > +}
> > +
> >  /*
> >   * VDM/VDO handling functions
> >   */
> > @@ -1164,6 +1407,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
> >               default:
> >                       break;
> >               }
> > +             tcpm_ams_start(port, port->ams, false);
> >               break;
> >       case CMDT_RSP_NAK:
> >               switch (cmd) {
> > @@ -1175,6 +1419,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
> >               default:
> >                       break;
> >               }
> > +             tcpm_ams_start(port, port->ams, false);
> >               break;
> >       default:
> >               break;
> > @@ -1260,7 +1505,7 @@ static unsigned int vdm_ready_timeout(u32 vdm_hdr)
> >  static void vdm_run_state_machine(struct tcpm_port *port)
> >  {
> >       struct pd_message msg;
> > -     int i, res;
> > +     int i, res = 0;
> >
> >       switch (port->vdm_state) {
> >       case VDM_STATE_READY:
> > @@ -1277,27 +1522,47 @@ static void vdm_run_state_machine(struct tcpm_port *port)
> >               if (port->state != SRC_READY && port->state != SNK_READY)
> >                       break;
> >
> > -             /* Prepare and send VDM */
> > -             memset(&msg, 0, sizeof(msg));
> > -             msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
> > -                                       port->pwr_role,
> > -                                       port->data_role,
> > -                                       port->negotiated_rev,
> > -                                       port->message_id, port->vdo_count);
> > -             for (i = 0; i < port->vdo_count; i++)
> > -                     msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
> > -             res = tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> > -             if (res < 0) {
> > -                     port->vdm_state = VDM_STATE_ERR_SEND;
> > -             } else {
> > -                     unsigned long timeout;
> > +             if (PD_VDO_CMDT(port->vdo_data[0]) == CMDT_INIT) {
> > +                     switch (PD_VDO_CMD(port->vdo_data[0])) {
> > +                     case CMD_DISCOVER_IDENT:
> > +                             res = tcpm_ams_start(port, DISCOVER_IDENTITY,
> > +                                                  true);
> > +                             break;
> > +                     case CMD_DISCOVER_SVID:
> > +                             res = tcpm_ams_start(port, DISCOVER_SVIDS,
> > +                                                  true);
> > +                             break;
> > +                     case CMD_DISCOVER_MODES:
> > +                             res = tcpm_ams_start(port, DISCOVER_MODES,
> > +                                                  true);
> > +                             break;
> > +                     case CMD_ENTER_MODE:
> > +                             res = tcpm_ams_start(port,
> > +                                                  DFP_TO_UFP_ENTER_MODE,
> > +                                                  true);
> > +                             break;
> > +                     case CMD_EXIT_MODE:
> > +                             res = tcpm_ams_start(port, DFP_TO_UFP_EXIT_MODE,
> > +                                                  true);
> > +                             break;
> > +                     case CMD_ATTENTION:
> > +                             res = tcpm_ams_start(port, ATTENTION, true);
> > +                             break;
> > +                     default:
> > +                             res = -EOPNOTSUPP;
> > +                             break;
> > +                     }
> >
> > -                     port->vdm_retries = 0;
> > -                     port->vdm_state = VDM_STATE_BUSY;
> > -                     timeout = vdm_ready_timeout(port->vdo_data[0]);
> > -                     mod_delayed_work(port->wq, &port->vdm_state_machine,
> > -                                      timeout);
> > +                     if (res == -EAGAIN)
> > +                             return;
> >               }
> > +
> > +             port->vdm_state = VDM_STATE_SEND_MESSAGE;
> > +             mod_delayed_work(port->wq, &port->vdm_state_machine,
> > +                              (res != -EOPNOTSUPP) &&
> > +                              (port->pwr_role == TYPEC_SOURCE) &&
> > +                              (PD_VDO_CMDT(port->vdo_data[0]) == CMDT_INIT) ?
> > +                              PD_T_SINK_TX : 0);
> >               break;
> >       case VDM_STATE_WAIT_RSP_BUSY:
> >               port->vdo_data[0] = port->vdo_retry;
> > @@ -1306,6 +1571,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
> >               break;
> >       case VDM_STATE_BUSY:
> >               port->vdm_state = VDM_STATE_ERR_TMOUT;
> > +             if (port->ams != NONE_AMS)
> > +                     tcpm_ams_start(port, port->ams, false);
> >               break;
> >       case VDM_STATE_ERR_SEND:
> >               /*
> > @@ -1318,6 +1585,30 @@ static void vdm_run_state_machine(struct tcpm_port *port)
> >                       tcpm_log(port, "VDM Tx error, retry");
> >                       port->vdm_retries++;
> >                       port->vdm_state = VDM_STATE_READY;
> > +                     tcpm_ams_start(port, port->ams, false);
> > +             }
> > +             break;
> > +     case VDM_STATE_SEND_MESSAGE:
> > +             /* Prepare and send VDM */
> > +             memset(&msg, 0, sizeof(msg));
> > +             msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
> > +                                       port->pwr_role,
> > +                                       port->data_role,
> > +                                       port->negotiated_rev,
> > +                                       port->message_id, port->vdo_count);
> > +             for (i = 0; i < port->vdo_count; i++)
> > +                     msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
> > +             res = tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> > +             if (res < 0) {
> > +                     port->vdm_state = VDM_STATE_ERR_SEND;
> > +             } else {
> > +                     unsigned long timeout;
> > +
> > +                     port->vdm_retries = 0;
> > +                     port->vdm_state = VDM_STATE_BUSY;
> > +                     timeout = vdm_ready_timeout(port->vdo_data[0]);
> > +                     mod_delayed_work(port->wq, &port->vdm_state_machine,
> > +                                      timeout);
> >               }
> >               break;
> >       default:
> > @@ -1341,7 +1632,8 @@ static void vdm_state_machine_work(struct work_struct *work)
> >               prev_state = port->vdm_state;
> >               vdm_run_state_machine(port);
> >       } while (port->vdm_state != prev_state &&
> > -              port->vdm_state != VDM_STATE_BUSY);
> > +              port->vdm_state != VDM_STATE_BUSY &&
> > +              port->vdm_state != VDM_STATE_SEND_MESSAGE);
> >
> >       mutex_unlock(&port->lock);
> >  }
> > @@ -1671,6 +1963,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >  {
> >       enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
> >       enum tcpm_state next_state;
> > +     int ret = 0;
> >
> >       switch (type) {
> >       case PD_CTRL_GOOD_CRC:
> > @@ -1785,11 +2078,19 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >               case SOFT_RESET_SEND:
> >                       port->message_id = 0;
> >                       port->rx_msgid = -1;
> > -                     if (port->pwr_role == TYPEC_SOURCE)
> > -                             next_state = SRC_SEND_CAPABILITIES;
> > -                     else
> > -                             next_state = SNK_WAIT_CAPABILITIES;
> > -                     tcpm_set_state(port, next_state, 0);
> > +                     if (port->ams == SOFT_RESET_AMS)
> > +                             tcpm_ams_start(port, port->ams, false);
> > +                     if (port->pwr_role == TYPEC_SOURCE) {
> > +                             port->upcoming_state = SRC_SEND_CAPABILITIES;
> > +                             ret = tcpm_ams_start(port, POWER_NEGOTIATION,
> > +                                                  true);
> > +                             if (ret == -EOPNOTSUPP)
> > +                                     tcpm_set_state(port,
> > +                                                    SRC_SEND_CAPABILITIES,
> > +                                                    0);
> > +                     } else {
> > +                             tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> > +                     }
> >                       break;
> >               case DR_SWAP_SEND:
> >                       tcpm_set_state(port, DR_SWAP_CHANGE_DR, 0);
> > @@ -2555,13 +2856,6 @@ static bool tcpm_start_drp_toggling(struct tcpm_port *port,
> >       return false;
> >  }
> >
> > -static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
> > -{
> > -     tcpm_log(port, "cc:=%d", cc);
> > -     port->cc_req = cc;
> > -     port->tcpc->set_cc(port->tcpc, cc);
> > -}
> > -
> >  static int tcpm_init_vbus(struct tcpm_port *port)
> >  {
> >       int ret;
> > @@ -2680,6 +2974,8 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
> >
> >  static void tcpm_reset_port(struct tcpm_port *port)
> >  {
> > +     port->in_ams = false;
> > +     port->ams = NONE_AMS;
> >       tcpm_unregister_altmodes(port);
> >       tcpm_typec_disconnect(port);
> >       port->attached = false;
> > @@ -2843,6 +3139,7 @@ static void run_state_machine(struct tcpm_port *port)
> >       int ret;
> >       enum typec_pwr_opmode opmode;
> >       unsigned int msecs;
> > +     enum tcpm_state upcoming_state;
> >
> >       port->enter_state = port->state;
> >       switch (port->state) {
> > @@ -2945,7 +3242,14 @@ static void run_state_machine(struct tcpm_port *port)
> >               port->message_id = 0;
> >               port->rx_msgid = -1;
> >               port->explicit_contract = false;
> > -             tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
> > +             /* SNK -> SRC POWER/FAST_ROLE_SWAP finished */
> > +             if (port->ams == POWER_ROLE_SWAP ||
> > +                 port->ams == FAST_ROLE_SWAP)
> > +                     tcpm_ams_start(port, port->ams, false);
> > +             port->upcoming_state = SRC_SEND_CAPABILITIES;
> > +             ret = tcpm_ams_start(port, POWER_NEGOTIATION, true);
> > +             if (ret == -EOPNOTSUPP)
> > +                     tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
>
> The state machine changes are substantial. As mentioned above, this
> will require a lot of review and substantial testing to ensure that existing
> implementations are not negatively affected.
>
> Quite frankly, my personal preference would be to try to find a less invasive
> implementation.
>
The changes only set CC (if the port is Source) and block the AMS from the
beginning if CC is SinkTxNG (if the port is Sink) or if current AMS is not
interruptible. They don't change the state machine except for some error
recovery and the changes for error recovery are defined in the Spec.

> >               break;
> >       case SRC_SEND_CAPABILITIES:
> >               port->caps_count++;
> > @@ -3003,6 +3307,18 @@ static void run_state_machine(struct tcpm_port *port)
> >               tcpm_swap_complete(port, 0);
> >               tcpm_typec_connect(port);
> >
> > +             if (port->ams != NONE_AMS)
> > +                     tcpm_ams_start(port, port->ams, false);
> > +             /*
> > +              * If previous AMS is interrupted, switch to the upcoming
> > +              * state.
> > +              */
> > +             upcoming_state = port->upcoming_state;
> > +             if (port->upcoming_state != INVALID_STATE) {
> > +                     tcpm_switch_state(port, upcoming_state, 0);
> > +                     break;
> > +             }
>
> Any reason for assigning the next state to upcoming_state and not using
> port->upcoming_state drectly ? The assignment followed by the re-use of
> port->upcoming_state is odd and seems unnecessary.
>
> Oh, I guess that tcpm_switch_state() is a macro and has the side effect
> of changing port->upcoming_state. This just asks for trouble in future
> patches, where people may not remember the context.
>
> Another problem is that it is not well explained when tcpm_switch_state()
> should now be called instead of tcpm_set_state(), with the only difference
> being that the latter does not set upcoming_state to INVALID_STATE.
> This is asking for even more trouble in the future, and really makes me
> wonder if the new macro is worth it.
>
I will remove the macro to see if it is more readable.

thanks,
Kyle
